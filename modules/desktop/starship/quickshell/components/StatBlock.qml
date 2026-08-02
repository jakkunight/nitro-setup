import QtQuick
import QtQuick.Layouts
import "../colors.js" as Colors

// A labelled HUD stat readout (label over value).
ColumnLayout {
  id: hudStatBlock
  property string label: ""
  property string value: "--"
  property string accent: Colors.base0C

  spacing: 1

  Text {
    text: hudStatBlock.label
    color: Colors.base04
    font.family: Colors.fontFamily
    font.pixelSize: 12
  }

  Text {
    text: hudStatBlock.value
    color: hudStatBlock.accent
    font.family: Colors.fontFamily
    font.pixelSize: 17
    font.weight: Font.DemiBold
  }
}
