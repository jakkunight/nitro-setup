import Quickshell
import Quickshell.Io
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
  property string netRx: "--"
  property string netTx: "--"
  property string temp: "--"
  property var workspaces: []
  property int activeWorkspace: 0
  property int volume: 0
  property bool muted: false
  property int backlight: 0

  // ---- helpers ----
  function withAlpha(hex, a) {
    var r = parseInt(hex.slice(1, 3), 16) / 255
    var g = parseInt(hex.slice(3, 5), 16) / 255
    var b = parseInt(hex.slice(5, 7), 16) / 255
    return Qt.rgba(r, g, b, a)
  }

  function gotoWorkspace(id) {
    wsDispatch.exec([Paths.hyprctl, "dispatch", "workspace", String(id)])
  }

  function setVolume(v) {
    volSet.exec([Paths.wpctl, "set-volume", "-l", "1", "@DEFAULT_AUDIO_SINK@", (v / 100).toFixed(2)])
  }

  function toggleMute() {
    volMute.exec([Paths.wpctl, "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])
  }

  function setBacklight(v) {
    backlightSet.exec([Paths.brightnessctl, "set", v + "%"])
  }

  // ---- per-screen panels ----
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: 40
      exclusiveZone: 40
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

          // ---------- left: workspaces + user ----------
          Row {
            Layout.alignment: Qt.AlignVCenter
            spacing: 10

            Row {
              spacing: 4
              Repeater {
                model: root.workspaces
                WorkspaceButton {
                  wsId: modelData
                  active: modelData === root.activeWorkspace
                  onActivate: root.gotoWorkspace(wsId)
                }
              }
            }

            UserBadge {
              anchors.verticalCenter: parent.verticalCenter
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
              font.pixelSize: 16
              font.weight: Font.DemiBold
            }

            Text {
              anchors.horizontalCenter: parent.horizontalCenter
              text: root.dateText
              color: Colors.base05
              font.family: Colors.fontFamily
              font.pixelSize: 9
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
            StatBlock { label: "RAM"; value: root.mem; accent: Colors.base0A }
            StatBlock { label: "DISK"; value: root.disk; accent: Colors.base0B }
            StatBlock { label: "TEMP"; value: root.temp; accent: Colors.base09 }

            // audio
            Column {
              spacing: 4
              Layout.alignment: Qt.AlignVCenter

              Text {
                text: root.muted ? "MUTED" : root.volume + "%"
                color: root.muted ? Colors.base08 : Colors.base05
                font.family: Colors.fontFamily
                font.pixelSize: 10
                font.weight: Font.DemiBold
              }

              HudSlider {
                value: root.volume
                maxValue: 100
                onChanged: root.setVolume(v)
              }

              // mute toggle
              Rectangle {
                width: 40
                height: 16
                radius: 3
                color: "transparent"
                border.color: root.muted ? Colors.base08 : Colors.base03
                border.width: 1

                Text {
                  anchors.centerIn: parent
                  text: "MUTE"
                  color: root.muted ? Colors.base08 : Colors.base05
                  font.family: Colors.fontFamily
                  font.pixelSize: 8
                }

                MouseArea {
                  anchors.fill: parent
                  onClicked: root.toggleMute()
                }
              }
            }

            // backlight
            Column {
              spacing: 4
              Layout.alignment: Qt.AlignVCenter

              Text {
                text: "BRT " + root.backlight + "%"
                color: Colors.base0D
                font.family: Colors.fontFamily
                font.pixelSize: 10
                font.weight: Font.DemiBold
              }

              HudSlider {
                value: root.backlight
                maxValue: 100
                onChanged: root.setBacklight(v)
              }
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
          var ids = []
          for (var i = 0; i < arr.length; i++) {
            if (arr[i].id > 0) ids.push(arr[i].id)
          }
          ids.sort(function (a, b) { return a - b })
          root.workspaces = ids
        } catch (e) {}
      }
    }
  }

  // Hyprland active workspace
  Process {
    id: wsActive
    command: [Paths.hyprctl, "activeworkspace", "-j"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          var obj = JSON.parse(this.text.trim())
          root.activeWorkspace = obj.id
        } catch (e) {}
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      wsList.running = true
      wsActive.running = true
    }
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
          root.mem = o.mem + "%"
          root.disk = o.disk + "%"
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
          root.volume = m ? Math.round(parseFloat(m[1]) * 100) : 0
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
          // device,class,subsystem,path,brightness,max,percent
          root.backlight = parts.length >= 7 ? parseInt(parts[6], 10) : 0
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

  // ---- one-shot dispatchers (started via exec) ----
  Process { id: wsDispatch }
  Process { id: volSet }
  Process { id: volMute }
  Process { id: backlightSet }
}
