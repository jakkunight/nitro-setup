import QtQuick
import "../colors.js" as Colors

// A single clickable Hyprland workspace indicator in the HUD bar.
Rectangle {
  id: hudWorkspaceButton
  property bool active: false
  property int wsId: 0
  signal activate(int id)
  signal moveTo(int id)

  width: 38
  height: 32
  radius: 4
  color: active ? Colors.base0C : "transparent"
  border.color: active ? Colors.base0C : (hovered ? Colors.base06 : Colors.base03)
  border.width: 1

  property bool hovered: false

  Text {
    anchors.centerIn: parent
    text: hudWorkspaceButton.wsId
    color: active ? Colors.base00 : Colors.base05
    font.family: Colors.fontFamily
    font.pixelSize: 16
    font.weight: Font.DemiBold
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton
    onEntered: hudWorkspaceButton.hovered = true
    onExited: hudWorkspaceButton.hovered = false
    onClicked: function (mouse) {
      if (mouse.button === Qt.LeftButton)
        hudWorkspaceButton.activate(hudWorkspaceButton.wsId)
      else if (mouse.button === Qt.MiddleButton)
        hudWorkspaceButton.moveTo(hudWorkspaceButton.wsId)
    }
  }
}
