import QtQuick
import "../colors.js" as Colors
import "../paths.js" as Paths

// Circular user avatar (${HOME}/.face) + username badge.
Row {
  id: hudUserBadge
  property string userName: Paths.userName

  spacing: 8

  Rectangle {
    width: 38
    height: 38
    radius: width / 2
    clip: true
    border.color: Colors.base0C
    border.width: 1

    Image {
      anchors.fill: parent
      source: Paths.face
      fillMode: Image.PreserveAspectCrop
    }
  }

  Column {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 1

    Text {
      text: hudUserBadge.userName
      color: Colors.base05
      font.family: Colors.fontFamily
      font.pixelSize: 15
      font.weight: Font.DemiBold
    }

    Text {
      text: "STARSHIP HUD"
      color: Colors.base0C
      font.family: Colors.fontFamily
      font.pixelSize: 11
    }
  }
}
