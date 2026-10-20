import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "colors.js" as Colors
import "paths.js" as Paths

// Starship Holographic Launcher — an application launcher spawned on demand
// (SUPER+SPACE / SUPER+D). Runs as its own quickshell instance (-n prevents
// stacking) and quits when an app is launched or the launcher is dismissed.
//
// Note: this build of quickshell (0.3.0) does not expose the implicit `index`
// special property when a ListView model is a `property var` JS array, so the
// selected entry is tracked by an integer `selectedIndex` plus name-based
// matching (`selectApp`/delegate highlight) rather than `index`/object identity.
ShellRoot {
  id: root

  property var allApps: []
  property var filtered: []
  property string query: ""
  property int selectedIndex: 0
  property var selectedApp: null

  // Hyprland.focusedMonitor is a HyprlandMonitor, but a PanelWindow's screen
  // must be a QuickshellScreenInfo — match them up by name.
  property var targetScreen: root.screenForMonitor(Hyprland.focusedMonitor)

  function screenForMonitor(monitor) {
    if (!monitor) return null
    var screens = Quickshell.screens
    for (var i = 0; i < screens.length; i++) {
      if (screens[i].name === monitor.name) return screens[i]
    }
    return null
  }

  function withAlpha(hex, a) {
    var r = parseInt(hex.slice(1, 3), 16) / 255
    var g = parseInt(hex.slice(3, 5), 16) / 255
    var b = parseInt(hex.slice(5, 7), 16) / 255
    return Qt.rgba(r, g, b, a)
  }

  // case-insensitive substring match on the name and generic name
  function filterApps() {
    var q = root.query.trim().toLowerCase()
    var out = []
    if (q === "") {
      out = root.allApps.slice()
    } else {
      for (var i = 0; i < root.allApps.length; i++) {
        var app = root.allApps[i]
        if (app.name.toLowerCase().indexOf(q) !== -1 ||
            (app.generic && app.generic.toLowerCase().indexOf(q) !== -1)) {
          out.push(app)
        }
      }
    }
    root.filtered = out
    root.selectedIndex = out.length > 0 ? 0 : -1
    root.selectedApp = out.length > 0 ? out[0] : null
    list.positionViewAtIndex(0, ListView.Beginning)
  }

  function moveSelection(delta) {
    var n = root.filtered.length
    if (n === 0) return
    var idx = root.selectedIndex === -1 ? 0 : root.selectedIndex
    idx = Math.max(0, Math.min(n - 1, idx + delta))
    root.selectedIndex = idx
    root.selectedApp = root.filtered[idx]
    list.positionViewAtIndex(idx, ListView.Contain)
  }

  function selectApp(app) {
    for (var i = 0; i < root.filtered.length; i++) {
      if (root.filtered[i].name === app.name) {
        root.selectedIndex = i
        break
      }
    }
    root.selectedApp = app
  }

  function launchApp(app) {
    // Prefer Quickshell's desktop-entry index: it parses the Exec line into a
    // safe argv list and runs with the entry's working directory, avoiding
    // `gio launch`'s failures with %-field codes and session-env differences.
    // launchApp's entry.execute() is equivalent to execDetached, so the app
    // outlives this launcher instance.
    if (app && app.path) {
      var slash = app.path.lastIndexOf("/")
      var base = slash >= 0 ? app.path.substring(slash + 1) : app.path
      var entry = base ? DesktopEntries.byId(base) : null
      if (!entry && base && base.indexOf(".desktop") === base.length - 8)
        entry = DesktopEntries.byId(base.substring(0, base.length - 8))
      if (!entry) entry = DesktopEntries.heuristicLookup(app.name)
      if (entry) {
        entry.execute()
        Qt.quit()
        return
      }
    }
    // Fallback: gio launch works for plain desktop entries without field codes.
    Quickshell.execDetached([Paths.gio, "launch", app.path])
    Qt.quit()
  }

  PanelWindow {
    id: launcherWindow
    screen: root.targetScreen
    focusable: true
    aboveWindows: true
    exclusiveZone: 0
    color: "transparent"

    // fill the focused monitor
    anchors {
      top: true
      left: true
      right: true
      bottom: true
    }
    margins {
      top: 0
      left: 0
      right: 0
      bottom: 0
    }

    onVisibleChanged: {
      if (visible) searchInput.forceActiveFocus()
    }

    // This instance is launched on demand and starts already visible, so
    // onVisibleChanged may never fire; grab focus unconditionally at startup
    // so the Keys handlers (Enter/Esc/Up/Down) actually receive input.
    Component.onCompleted: searchInput.forceActiveFocus()

    // full-screen backdrop: clicking anywhere outside the card dismisses the
    // launcher, without relying on fragile focus-change tracking.
    MouseArea {
      anchors.fill: parent
      onPressed: Qt.quit()

      Rectangle {
        anchors.fill: parent
        color: root.withAlpha(Colors.base00, 0.55)
      }
    }

    // centered card
    Rectangle {
      id: card
      width: 560
      height: 500
      anchors.centerIn: parent
      radius: 8
      color: root.withAlpha(Colors.base00, 0.95)
      border.color: Colors.base0C
      border.width: 1
      clip: true

      // swallow clicks on empty card space so they don't reach the backdrop
      MouseArea {
        anchors.fill: parent
        onClicked: {}
      }

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 10

        // ---- search box ----
        Rectangle {
          Layout.fillWidth: true
          Layout.preferredHeight: 42
          radius: 4
          color: root.withAlpha(Colors.base01, 0.6)
          border.color: Colors.base0C
          border.width: 1

          Text {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 12
            visible: searchInput.text === ""
            text: "SEARCH PROGRAMS"
            color: Colors.base04
            font.family: Colors.fontFamily
            font.pixelSize: 13
          }

          TextInput {
            id: searchInput
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            verticalAlignment: TextInput.AlignVCenter
            color: Colors.base05
            selectionColor: root.withAlpha(Colors.base0C, 0.4)
            selectedTextColor: Colors.base00
            font.family: Colors.fontFamily
            font.pixelSize: 16

            onTextChanged: {
              root.query = searchInput.text
              root.filterApps()
            }

            Keys.onPressed: function (event) {
              if (event.key === Qt.Key_Escape) {
                event.accepted = true
                Qt.quit()
              } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                event.accepted = true
                if (root.selectedApp) root.launchApp(root.selectedApp)
              } else if (event.key === Qt.Key_Up) {
                event.accepted = true
                root.moveSelection(-1)
              } else if (event.key === Qt.Key_Down) {
                event.accepted = true
                root.moveSelection(1)
              } else if (event.key === Qt.Key_PageUp) {
                event.accepted = true
                root.moveSelection(-10)
              } else if (event.key === Qt.Key_PageDown) {
                event.accepted = true
                root.moveSelection(10)
              }
            }
          }
        }

        // ---- results list ----
        ListView {
          id: list
          Layout.fillWidth: true
          Layout.fillHeight: true
          model: root.filtered
          clip: true
          spacing: 2
          boundsBehavior: Flickable.StopAtBounds

          delegate: Rectangle {
            id: entry
            required property var modelData
            property bool selected: root.selectedApp !== null && entry.modelData.name === root.selectedApp.name
            property string iconSource: {
              if (entry.modelData.icon === "") return ""
              if (entry.modelData.icon.indexOf("/") >= 0) return entry.modelData.icon
              return Quickshell.hasThemeIcon(entry.modelData.icon)
                ? Quickshell.iconPath(entry.modelData.icon) : ""
            }

            width: list.width
            height: 46
            radius: 4
            color: entry.selected ? root.withAlpha(Colors.base0C, 0.25) : "transparent"
            border.color: entry.selected ? Colors.base0C : "transparent"
            border.width: 1

            RowLayout {
              anchors.fill: parent
              anchors.leftMargin: 10
              anchors.rightMargin: 10
              spacing: 10

              Item {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30

                Image {
                  anchors.fill: parent
                  visible: entry.iconSource !== ""
                  source: entry.iconSource
                  fillMode: Image.PreserveAspectFit
                }

                // monochrome letter-tile fallback (mirrors the UserBadge look)
                Rectangle {
                  visible: entry.iconSource === ""
                  anchors.fill: parent
                  radius: 4
                  color: root.withAlpha(Colors.base0C, 0.15)
                  border.color: Colors.base0C
                  border.width: 1

                  Text {
                    anchors.centerIn: parent
                    text: entry.modelData.name.length > 0 ? entry.modelData.name.charAt(0).toUpperCase() : "?"
                    color: Colors.base0C
                    font.family: Colors.fontFamily
                    font.pixelSize: 15
                    font.weight: Font.DemiBold
                  }
                }
              }

              Column {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                spacing: 1

                Text {
                  text: entry.modelData.name
                  color: entry.selected ? Colors.base00 : Colors.base05
                  font.family: Colors.fontFamily
                  font.pixelSize: 14
                  font.weight: Font.DemiBold
                  elide: Text.ElideRight
                }

                Text {
                  visible: entry.modelData.generic !== "" && entry.modelData.generic !== entry.modelData.name
                  text: entry.modelData.generic
                  color: Colors.base04
                  font.family: Colors.fontFamily
                  font.pixelSize: 11
                  elide: Text.ElideRight
                }
              }
            }

            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              onEntered: root.selectApp(entry.modelData)
              onClicked: root.launchApp(entry.modelData)
            }
          }
        }
      }
    }
  }

  // ---- data source: scan the application dirs once at startup ----
  Process {
    id: appsProc
    command: [Paths.apps]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          root.allApps = JSON.parse(this.text.trim())
          root.filterApps()
        } catch (e) {}
      }
    }
  }
}
