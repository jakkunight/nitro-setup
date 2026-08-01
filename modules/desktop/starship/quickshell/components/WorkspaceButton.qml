import QtQuick
import "../colors.js" as Colors

// A single clickable Hyprland workspace indicator in the HUD bar.
Rectangle {
  id: hudWorkspaceButton
  property bool active: false
  property int wsId: 0
  signal activate(int id)

  width: 30
  height: 26
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
    font.pixelSize: 13
    font.weight: Font.DemiBold
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: hudWorkspaceButton.hovered = true
    onExited: hudWorkspaceButton.hovered = false
    onClicked: hudWorkspaceButton.activate(hudWorkspaceButton.wsId)
  }
}
