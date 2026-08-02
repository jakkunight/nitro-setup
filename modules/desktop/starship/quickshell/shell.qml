import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import "colors.js" as Colors
import "paths.js" as Paths
import "components"

// Starship Holographic HUD — a top bar rendered by Quickshell.
ShellRoot {
  id: root

  // ---- shared state (updated by the Processes below) ----
  property string timeText: "--:--"
  property string dateText: ""
  property string cpu: "--"
  property string mem: "--"
  property string disk: "--"
  // raw stats (KiB) kept for the hover popup's total / used-percent readout
  property int memUsed: 0
  property int memTotal: 0
  property int diskUsed: 0
  property int diskTotal: 0
  property string netRx: "--"
  property string netTx: "--"
  property string temp: "--"
  property var workspaces: []
  // Live-updates from Hyprland's event socket via the Quickshell.Hyprland
  // singleton (the focused monitor's activeWorkspaceChanged fires instantly on
  // workspace switches, no 1s polling involved). Null-safe: 0 when nothing is
  // focused. Uses the monitor (not the focused *window*), so empty workspaces
  // are tracked correctly.
  property int activeWorkspace: Hyprland.focusedMonitor ? Hyprland.focusedMonitor.activeWorkspace.id : 0
  property int volume: 0
  property bool muted: false
  property int backlight: 0
  property bool volumeApplying: false
  // true while a `brightnessctl set` is in flight so the polling process does
  // not overwrite the optimistic UI value with a stale reading.
  property bool backlightApplying: false

  // mic (capture) mute state + input level.
  property int micVolume: 0
  property bool micMuted: false
  property bool micApplying: false

  // bluetooth adapter power state (polled), so the toggle can flip it.
  property bool bluetooth: false
  property bool bluetoothApplying: false

  // notification daemon state
  property int notificationCount: 0
  property bool doNotDisturb: false

  // ---- helpers ----
  function withAlpha(hex, a) {
    var r = parseInt(hex.slice(1, 3), 16) / 255
    var g = parseInt(hex.slice(3, 5), 16) / 255
    var b = parseInt(hex.slice(5, 7), 16) / 255
    return Qt.rgba(r, g, b, a)
  }

  // Formats a KiB value with base-1024 units (KiB/MiB/GiB/TiB), never KB/MB/GB.
  // The stats script reports /proc/meminfo and `df -Pk` in KiB already.
  function formatKiB(kib) {
    var units = ["KiB", "MiB", "GiB", "TiB"]
    var i = 0
    var v = kib
    while (v >= 1024 && i < units.length - 1) {
      v /= 1024
      i++
    }
    var text = v >= 100 ? v.toFixed(0) : String(parseFloat(v.toFixed(1)))
    return text + " " + units[i]
  }

  function gotoWorkspace(id) {
    // This Hyprland runs a Lua config, so dispatches must use the Lua form:
    //   hyprctl dispatch 'hl.dsp.focus({ workspace = 2 })'
    // The whole expression is passed as ONE argument (no shell involved).
    wsDispatch.exec([Paths.hyprctl, "dispatch", "hl.dsp.focus({ workspace = " + String(id) + " })"])
  }

  function moveWindowToWorkspace(id) {
    wsDispatch.exec([Paths.hyprctl, "dispatch", "hl.dsp.window.move({ workspace = " + String(id) + ", follow = false })"])
  }

  function scrollWorkspaces(deltaY) {
    wsDispatch.exec([Paths.hyprctl, "dispatch", 'hl.dsp.focus({ workspace = "' + (deltaY > 0 ? "+1" : "-1") + '" })'])
  }

  function adjustVolume(delta) {
    var v = Math.max(0, Math.min(100, root.volume + delta))
    root.volume = v
    root.setVolume(v)
  }

  function setVolume(v) {
    root.volumeApplying = true
    volSet.exec([Paths.wpctl, "set-volume", "-l", "1", "@DEFAULT_AUDIO_SINK@", (v / 100).toFixed(2)])
    volumeApplyHold.restart()
  }

  function toggleMute() {
    volMute.exec([Paths.wpctl, "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])
  }

  function adjustMicVolume(delta) {
    var v = Math.max(0, Math.min(100, root.micVolume + delta))
    root.micVolume = v
    root.setMicVolume(v)
  }

  function setMicVolume(v) {
    root.micApplying = true
    micSet.exec([Paths.wpctl, "set-volume", "-l", "1", "@DEFAULT_AUDIO_SOURCE@", (v / 100).toFixed(2)])
    micApplyHold.restart()
  }

  function toggleMicMute() {
    micMute.exec([Paths.wpctl, "set-mute", "@DEFAULT_AUDIO_SOURCE@", "toggle"])
  }

  function toggleBluetooth() {
    root.bluetoothApplying = true
    var cmd = root.bluetooth ? "off" : "on"
    bluetoothToggle.exec([Paths.bluetoothctl, "power", cmd])
    bluetoothApplyHold.restart()
  }

  function adjustBacklight(delta) {
    var v = Math.max(0, Math.min(100, root.backlight + delta))
    root.backlight = v
    root.setBacklight(v)
  }

  function setBacklight(v) {
    root.backlightApplying = true
    backlightSet.exec([Paths.brightnessctl, "set", v + "%"])
    backlightApplyHold.restart()
  }

  // ---- per-screen panels ----
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: 56
      exclusiveZone: 56
      color: root.withAlpha(Colors.base00, 0.88)

      Rectangle {
        anchors.fill: parent
        color: "transparent"

        // holographic baseline
        Rectangle {
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          height: 1
          color: Colors.base0C
        }

        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: 12
          anchors.rightMargin: 12
          spacing: 12

          // ---------- left: user + workspaces ----------
          Row {
            Layout.alignment: Qt.AlignVCenter
            spacing: 10

            // user profile pinned to the far-left corner
            UserBadge {
              anchors.verticalCenter: parent.verticalCenter
            }

            // workspace buttons: left-click switches, middle-click moves the
            // focused window, wheel scrolls through workspaces
            Item {
              implicitWidth: workspacesRow.implicitWidth
              implicitHeight: workspacesRow.implicitHeight

              Row {
                id: workspacesRow
                spacing: 4
                Repeater {
                  model: root.workspaces
                  WorkspaceButton {
                    wsId: modelData
                    active: modelData === root.activeWorkspace
                    onActivate: root.gotoWorkspace(wsId)
                    onMoveTo: root.moveWindowToWorkspace(id)
                  }
                }
              }

              // transparent overlay: catches wheel only, clicks pass through
              MouseArea {
                anchors.fill: workspacesRow
                acceptedButtons: Qt.NoButton
                onWheel: function (wheel) {
                  root.scrollWorkspaces(wheel.angleDelta.y)
                }
              }
            }
          }

          Item { Layout.fillWidth: true }

          // ---------- center: date/time ----------
          Column {
            Layout.alignment: Qt.AlignVCenter
            spacing: 0

            Text {
              anchors.horizontalCenter: parent.horizontalCenter
              text: root.timeText
              color: Colors.base0C
              font.family: Colors.fontFamily
              font.pixelSize: 22
              font.weight: Font.DemiBold
            }

            Text {
              anchors.horizontalCenter: parent.horizontalCenter
              text: root.dateText
              color: Colors.base05
              font.family: Colors.fontFamily
              font.pixelSize: 12
            }
          }

          Item { Layout.fillWidth: true }

          // ---------- right: stats + controls ----------
          Row {
            Layout.alignment: Qt.AlignVCenter
            spacing: 12

            StatBlock { label: "NET RX"; value: root.netRx; accent: Colors.base0C }
            StatBlock { label: "NET TX"; value: root.netTx; accent: Colors.base0D }
            StatBlock { label: "CPU"; value: root.cpu; accent: Colors.base0E }

            // hoverable RAM readout (hover pops up total + used %)
            Item {
              implicitWidth: ramBlock.implicitWidth
              implicitHeight: ramBlock.implicitHeight

              StatBlock {
                id: ramBlock
                label: "RAM"
                value: root.mem
                accent: Colors.base0A
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: showStatsPopup(ramBlock, "RAM", root.memUsed, root.memTotal)
                onExited: hideStatsPopup()
              }
            }

            // hoverable DISK readout (hover pops up total + used %)
            Item {
              implicitWidth: diskBlock.implicitWidth
              implicitHeight: diskBlock.implicitHeight

              StatBlock {
                id: diskBlock
                label: "DISK"
                value: root.disk
                accent: Colors.base0B
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: showStatsPopup(diskBlock, "DISK", root.diskUsed, root.diskTotal)
                onExited: hideStatsPopup()
              }
            }

            StatBlock { label: "TEMP"; value: root.temp; accent: Colors.base09 }

            // audio
            Item {
              Layout.alignment: Qt.AlignVCenter
              implicitWidth: audioCol.implicitWidth
              implicitHeight: audioCol.implicitHeight

              Column {
                id: audioCol
                spacing: 4

                Text {
                  text: root.muted ? "MUTED" : root.volume + "%"
                  color: root.muted ? Colors.base08 : Colors.base05
                  font.family: Colors.fontFamily
                  font.pixelSize: 13
                  font.weight: Font.DemiBold
                }

                HudSlider {
                  value: root.volume
                  maxValue: 100
                  onChanged: function (v) {
                    root.volume = v
                    root.setVolume(v)
                  }
                }

                // mute toggle
                Rectangle {
                  width: 40
                  height: 20
                  radius: 3
                  color: "transparent"
                  border.color: root.muted ? Colors.base08 : Colors.base03
                  border.width: 1

                  Text {
                    anchors.centerIn: parent
                    text: "MUTE"
                    color: root.muted ? Colors.base08 : Colors.base05
                    font.family: Colors.fontFamily
                    font.pixelSize: 11
                  }

                  MouseArea {
                    anchors.fill: parent
                    onClicked: root.toggleMute()
                  }
                }
              }

              // transparent overlay: wheel over the whole audio block
              MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.NoButton
                onWheel: function (wheel) {
                  root.adjustVolume(wheel.angleDelta.y > 0 ? 5 : -5)
                }
              }
            }

            // mic (capture) mute + input level
            Item {
              Layout.alignment: Qt.AlignVCenter
              implicitWidth: micCol.implicitWidth
              implicitHeight: micCol.implicitHeight

              Column {
                id: micCol
                spacing: 4

                Text {
                  text: root.micMuted ? "MIC OFF" : "MIC " + root.micVolume + "%"
                  color: root.micMuted ? Colors.base08 : Colors.base05
                  font.family: Colors.fontFamily
                  font.pixelSize: 13
                  font.weight: Font.DemiBold
                }

                HudSlider {
                  value: root.micVolume
                  maxValue: 100
                  onChanged: function (v) {
                    root.micVolume = v
                    root.setMicVolume(v)
                  }
                }

                // mic mute toggle
                Rectangle {
                  width: 40
                  height: 20
                  radius: 3
                  color: "transparent"
                  border.color: root.micMuted ? Colors.base08 : Colors.base03
                  border.width: 1

                  Text {
                    anchors.centerIn: parent
                    text: "MUTE"
                    color: root.micMuted ? Colors.base08 : Colors.base05
                    font.family: Colors.fontFamily
                    font.pixelSize: 11
                  }

                  MouseArea {
                    anchors.fill: parent
                    onClicked: root.toggleMicMute()
                  }
                }
              }

              // transparent overlay: wheel over the whole mic block
              MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.NoButton
                onWheel: function (wheel) {
                  root.adjustMicVolume(wheel.angleDelta.y > 0 ? 5 : -5)
                }
              }
            }

            // backlight
            Item {
              Layout.alignment: Qt.AlignVCenter
              implicitWidth: backlightCol.implicitWidth
              implicitHeight: backlightCol.implicitHeight

              Column {
                id: backlightCol
                spacing: 4

                Text {
                  text: "BRT " + root.backlight + "%"
                  color: Colors.base0D
                  font.family: Colors.fontFamily
                  font.pixelSize: 13
                  font.weight: Font.DemiBold
                }

                HudSlider {
                  value: root.backlight
                  maxValue: 100
                  onChanged: function (v) {
                    root.backlight = v
                    root.setBacklight(v)
                  }
                }
              }

              // transparent overlay: wheel over the whole backlight block
              MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.NoButton
                onWheel: function (wheel) {
                  root.adjustBacklight(wheel.angleDelta.y > 0 ? 5 : -5)
                }
              }
            }

            // bluetooth toggle (click toggles adapter power; reflects state)
            Item {
              Layout.alignment: Qt.AlignVCenter
              implicitWidth: btBlock.implicitWidth
              implicitHeight: btBlock.implicitHeight

              StatBlock {
                id: btBlock
                label: "BT"
                value: root.bluetooth ? "ON" : "OFF"
                accent: root.bluetooth ? Colors.base0B : Colors.base08
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.toggleBluetooth()
              }
            }

            // notification indicator (count; click toggles DND, double-click clears)
            Item {
              Layout.alignment: Qt.AlignVCenter
              implicitWidth: notifBlock.implicitWidth
              implicitHeight: notifBlock.implicitHeight

              StatBlock {
                id: notifBlock
                label: "NOTIF"
                value: root.notificationCount > 0 ? String(root.notificationCount) : "—"
                accent: root.doNotDisturb ? Colors.base08 : (root.notificationCount > 0 ? Colors.base0B : Colors.base04)
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.doNotDisturb = !root.doNotDisturb
                onDoubleClicked: {
                  var notifs = notifServer.trackedNotifications.values
                  for (var i = 0; i < notifs.length; i++) {
                    notifs[i].dismiss()
                  }
                }
              }
            }
          }
        }
      }

      // ---- RAM / DISK hover popup ----
      // One xdg_popup per screen, positioned under the hovered block using the
      // same anchor/onAnchoring pattern as Quickshell's built-in Tooltip.
      function showStatsPopup(item, title, usedKiB, totalKiB) {
        hudPopup.anchorItem = item
        hudPopup.popupTitle = title
        hudPopup.popupUsed = root.formatKiB(usedKiB)
        hudPopup.popupTotal = root.formatKiB(totalKiB)
        hudPopup.popupPercent = totalKiB > 0 ? Math.round(usedKiB / totalKiB * 100) + "%" : "0%"
        hudPopup.visible = true
      }

      function hideStatsPopup() {
        hudPopup.visible = false
      }

      PopupWindow {
        id: hudPopup
        visible: false
        width: 220
        height: content.implicitHeight + 20

        property Item anchorItem: null
        property string popupTitle: ""
        property string popupUsed: "--"
        property string popupTotal: "--"
        property string popupPercent: "--"

        // repositioned on each show: mapped from the hovered block into the
        // panel window's coordinate space, then nudged below the block
        anchor {
          window: panel
          adjustment: PopupAdjustment.Flip | PopupAdjustment.Slide
          gravity: Edges.Bottom | Edges.Right

          onAnchoring: {
            var pos = panel.contentItem.mapFromItem(
              hudPopup.anchorItem,
              hudPopup.anchorItem.width / 2 - hudPopup.width / 2,
              hudPopup.anchorItem.height + 6
            )
            hudPopup.anchor.rect.x = pos.x
            hudPopup.anchor.rect.y = pos.y
          }
        }

        Rectangle {
          anchors.fill: parent
          radius: 6
          color: root.withAlpha(Colors.base00, 0.95)
          border.color: Colors.base03
          border.width: 1

          Column {
            id: content
            anchors.fill: parent
            anchors.margins: 10
            spacing: 4

            Text {
              text: hudPopup.popupTitle
              color: Colors.base04
              font.family: Colors.fontFamily
              font.pixelSize: 12
            }

            Text {
              text: "Total: " + hudPopup.popupTotal
              color: Colors.base05
              font.family: Colors.fontFamily
              font.pixelSize: 13
            }

            Text {
              text: "Used: " + hudPopup.popupUsed + " (" + hudPopup.popupPercent + ")"
              color: Colors.base0C
              font.family: Colors.fontFamily
              font.pixelSize: 13
              font.weight: Font.DemiBold
            }
          }
        }
      }
    }
  }

  // ---- clock ----
  SystemClock {
    id: clock
    precision: SystemClock.Seconds

    onDateChanged: {
      root.timeText = Qt.formatTime(date, "HH:mm")
      root.dateText = Qt.formatDate(date, "ddd MMM d")
    }

    Component.onCompleted: {
      root.timeText = Qt.formatTime(date, "HH:mm")
      root.dateText = Qt.formatDate(date, "ddd MMM d")
    }
  }

  // ---- data sources ----

  // Hyprland workspaces
  Process {
    id: wsList
    command: [Paths.hyprctl, "workspaces", "-j"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          var arr = JSON.parse(this.text.trim())
          // always show a fixed set 1-9 plus any workspaces above 9 so the
          // panel stays usable before any workspace has been created.
          var extras = []
          for (var i = 0; i < arr.length; i++) {
            var id = arr[i].id
            if (id > 9) extras.push(id)
          }
          var merged = []
          for (var w = 1; w <= 9; w++) merged.push(w)
          for (var e = 0; e < extras.length; e++) merged.push(extras[e])
          merged.sort(function (a, b) { return a - b })
          root.workspaces = merged
        } catch (e) {}
      }
    }
  }

  // activeWorkspace is now event-driven via the Quickshell.Hyprland singleton
  // (see the property declaration above); the old `hyprctl activeworkspace -j`
  // poll was removed because a 1s stale write would clobber the fresh binding.

  // Refresh the workspace list promptly when workspaces are created/destroyed/
  // moved from any source (HUD clicks, wheel, external keybinds). The 1s timer
  // below remains only as a fallback safety net.
  Connections {
    target: Hyprland
    function onRawEvent(event) {
      var n = event.name
      if (n === "createworkspacev2" || n === "destroyworkspacev2" || n === "moveworkspacev2")
        wsList.running = true
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: wsList.running = true
  }

  // CPU / RAM / disk / net / temp stats
  Process {
    id: statsProc
    command: [Paths.stats]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          var o = JSON.parse(this.text.trim())
          root.cpu = o.cpu + "%"
          root.mem = root.formatKiB(o.memused)
          root.disk = root.formatKiB(o.diskused)
          root.memUsed = parseInt(o.memused, 10)
          root.memTotal = parseInt(o.memtotal, 10)
          root.diskUsed = parseInt(o.diskused, 10)
          root.diskTotal = parseInt(o.disktotal, 10)
          root.netRx = o.netrx + " KB/s"
          root.netTx = o.nettx + " KB/s"
          root.temp = o.temp + "°C"
        } catch (e) {}
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: statsProc.running = true
  }

  // audio volume
  Process {
    id: volGet
    command: [Paths.wpctl, "get-volume", "@DEFAULT_AUDIO_SINK@"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          var s = this.text.trim()
          var m = s.match(/([\d.]+)/)
          var parsed = m ? Math.round(parseFloat(m[1]) * 100) : 0
          if (!root.volumeApplying) root.volume = parsed
          root.muted = s.indexOf("MUTED") !== -1
        } catch (e) {}
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: volGet.running = true
  }

  // backlight
  Process {
    id: backlightGet
    command: [Paths.brightnessctl, "-m"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          var line = this.text.trim().split("\n")[0]
          var parts = line.split(",")
          // `brightnessctl -m` prints: device,class,current,max,percent
          // e.g. intel_backlight,backlight,7680,40%,19200
          // -> the percent (with a trailing '%') is at index 3, NOT index 6.
          var pct = parts.length >= 4 ? parseInt(parts[3], 10) : NaN
          if (!root.backlightApplying && !isNaN(pct)) root.backlight = pct
        } catch (e) {}
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: backlightGet.running = true
  }

  // window during which a just-issued `brightnessctl set` is expected to land;
  // the poll above will not overwrite the UI while this timer is running.
  Timer {
    id: backlightApplyHold
    interval: 400
    repeat: false
    onTriggered: root.backlightApplying = false
  }

  // window during which a just-issued `wpctl set-volume` is expected to land;
  // the volGet poll will not overwrite the UI while this timer is running.
  Timer {
    id: volumeApplyHold
    interval: 400
    repeat: false
    onTriggered: root.volumeApplying = false
  }

  // ---- one-shot dispatchers (started via exec) ----
  Process { id: wsDispatch }
  Process { id: volSet }
  Process { id: volMute }
  Process { id: micSet }
  Process { id: micMute }
  Process { id: bluetoothToggle }
  Process { id: backlightSet }

  // audio mic (capture) volume / mute state. Mirrors the sink volGet above so
  // the MUTE toggle and slider reflect the default audio source (the mic).
  Process {
    id: micGet
    command: [Paths.wpctl, "get-volume", "@DEFAULT_AUDIO_SOURCE@"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          var s = this.text.trim()
          var m = s.match(/([\d.]+)/)
          var parsed = m ? Math.round(parseFloat(m[1]) * 100) : 0
          if (!root.micApplying) root.micVolume = parsed
          root.micMuted = s.indexOf("MUTED") !== -1
        } catch (e) {}
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: micGet.running = true
  }

  // window during which a just-issued `wpctl set-volume @DEFAULT_AUDIO_SOURCE@`
  // is expected to land; the micGet poll will not overwrite the UI meanwhile.
  Timer {
    id: micApplyHold
    interval: 400
    repeat: false
    onTriggered: root.micApplying = false
  }

  // bluetooth adapter power state (bluetoothctl show -> "Powered: yes/no").
  Process {
    id: bluetoothGet
    command: [Paths.bluetoothctl, "show"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          if (!root.bluetoothApplying) root.bluetooth = this.text.indexOf("Powered: yes") !== -1
        } catch (e) {}
      }
    }
  }

  Timer {
    interval: 3000
    running: true
    repeat: true
    onTriggered: bluetoothGet.running = true
  }

  // window during which a just-issued `bluetoothctl power` toggle is expected
  // to land; the bluetoothGet poll will not overwrite the UI meanwhile.
  Timer {
    id: bluetoothApplyHold
    interval: 800
    repeat: false
    onTriggered: root.bluetoothApplying = false
  }

  // ---- notification daemon ----
  // Registers as org.freedesktop.Notifications on the D-Bus session bus,
  // receives notifications from any app, and displays them as popup bubbles
  // stacked in the top-right corner of each screen. Replaces swaync/mako.
  NotificationServer {
    id: notifServer
    keepOnReload: true
    bodySupported: true
    actionsSupported: true
    inlineReplySupported: false
    imageSupported: true
    actionIconsSupported: true
    persistenceSupported: false
    

    onNotification: function(notification) {
      notification.tracked = true
    }
  }

  // Update the in-bar notification count whenever tracked notifications change.
  Connections {
    target: notifServer
    function onTrackedNotificationsChanged() {
      root.notificationCount = notifServer.trackedNotifications.count
    }
  }

  // One popup panel per screen, bound to the server's trackedNotifications.
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      anchors { top: true; right: true }
      exclusiveZone: 0
      margins { top: 8; right: 12; left: 0; bottom: 0 }
      color: "transparent"
      visible: notifServer.trackedNotifications.count > 0 && !root.doNotDisturb

      Column {
        anchors.fill: parent
        anchors.bottom: parent.bottom
        spacing: 6
        transformOrigin: Item.BottomRight

        Repeater {
          model: notifServer.trackedNotifications

          NotificationPopup {
            notification: modelData
            colorRoot: root
          }
        }
      }
    }
  }
}
