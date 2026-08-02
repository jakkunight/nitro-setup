import Quickshell
import QtQuick
import QtQuick.Layouts

// A single notification bubble displayed by the starship HUD's
// NotificationServer. Shows app icon/name, summary, body, action buttons,
// and auto-dismisses after a timeout (critical notifications stay until
// dismissed). Designed to be lightweight and instantaneous — no per-notification
// process spawns, everything is in-process QML.
//
// The Repeater in shell.qml binds each NotificationPopup to a Notification
// object from notifServer.trackedNotifications (an ObjectModel<Notification>).
// When the notification is dismissed/expired, Quickshell removes it from the
// ObjectModel and the Repeater automatically destroys this delegate.
Item {
  id: popup

  // The notification object this popup is bound to (set by the Repeater).
  required property var notification

  // Passed from the parent shell for color alpha helper.
  required property var colorRoot

  implicitWidth: 360
  implicitHeight: contentCol.implicitHeight + 24

  // Urgency: 0 = Low, 1 = Normal, 2 = Critical (per the spec).
  // Critical notifications stay until dismissed; others auto-dismiss.
  readonly property int timeoutMs: {
    if (!popup.notification) return 5000
    if (popup.notification.expireTimeout > 0) {
      return popup.notification.expireTimeout
    }
    return popup.notification.urgency === 2 ? 0 : 5000
  }

  // Auto-dismiss timer (0 = never, for critical).
  Timer {
    id: dismissTimer
    interval: popup.timeoutMs
    running: popup.timeoutMs > 0
    repeat: false
    onTriggered: {
      if (popup.notification) popup.notification.expire()
    }
  }

  Rectangle {
    anchors.fill: parent
    radius: 6
    color: popup.colorRoot ? popup.colorRoot.withAlpha(Colors.base00, 0.95) : Colors.base00
    border.color: {
      if (!popup.notification) return Colors.base03
      switch (popup.notification.urgency) {
        case 0: return Colors.base04
        case 2: return Colors.base08
        default: return Colors.base0C
      }
    }
    border.width: 1
    clip: true

    Column {
      id: contentCol
      anchors.fill: parent
      anchors.margins: 12
      spacing: 6

      // App name + urgency indicator
      RowLayout {
        spacing: 8

        Text {
          text: popup.notification ? popup.notification.appName : ""
          color: Colors.base04
          font.family: Colors.fontFamily
          font.pixelSize: 11
          font.weight: Font.Bold
          elide: Text.ElideRight
          horizontalAlignment: Text.AlignLeft
        }

        Rectangle {
          visible: popup.notification && popup.notification.urgency > 0
          Layout.preferredWidth: 6
          Layout.preferredHeight: 6
          radius: 3
          color: {
            if (!popup.notification) return Colors.base03
            return popup.notification.urgency === 2 ? Colors.base08 : Colors.base0B
          }
        }
      }

      // Summary
      Text {
        text: popup.notification ? popup.notification.summary : ""
        color: Colors.base05
        font.family: Colors.fontFamily
        font.pixelSize: 14
        font.weight: Font.Bold
        wrapMode: Text.WordWrap
        width: parent.width
      }

      // Body
      Text {
        text: popup.notification ? popup.notification.body : ""
        color: Colors.base05
        font.family: Colors.fontFamily
        font.pixelSize: 12
        wrapMode: Text.WordWrap
        width: parent.width
        visible: popup.notification && popup.notification.body.length > 0
      }

      // Action buttons
      Row {
        id: actionRow
        spacing: 6
        visible: popup.notification && popup.notification.actions.length > 0

        Repeater {
          model: {
            var actions = []
            if (popup.notification && popup.notification.actions) {
              for (var i = 0; i < popup.notification.actions.length; i++) {
                actions.push(popup.notification.actions[i].label)
              }
            }
            return actions
          }

          delegate: Rectangle {
            required property string modelData
            width: 90
            height: 24
            radius: 4
            color: popup.colorRoot ? popup.colorRoot.withAlpha(Colors.base0C, 0.15) : Colors.base0C
            border.color: Colors.base0C
            border.width: 1

            Text {
              anchors.centerIn: parent
              text: modelData
              color: Colors.base0C
              font.family: Colors.fontFamily
              font.pixelSize: 11
              font.weight: Font.DemiBold
              elide: Text.ElideRight
            }

            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              onClicked: {
                if (popup.notification && popup.notification.actions) {
                  for (var i = 0; i < popup.notification.actions.length; i++) {
                    if (popup.notification.actions[i].label === modelData) {
                      popup.notification.actions[i].activate()
                      break
                    }
                  }
                }
                if (popup.notification) popup.notification.dismiss()
              }
            }
          }
        }
      }

      // Close button (top-right)
      MouseArea {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: -4
        width: 16
        height: 16
        cursorShape: Qt.PointingHandCursor
        visible: popup.notification !== null
        onClicked: {
          if (popup.notification) popup.notification.dismiss()
        }

        Text {
          anchors.centerIn: parent
          text: "×"
          color: Colors.base04
          font.family: Colors.fontFamily
          font.pixelSize: 14
          font.weight: Font.Bold
        }
      }
    }
  }
}
