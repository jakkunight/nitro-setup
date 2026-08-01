import QtQuick
import "../colors.js" as Colors

// A minimalist HUD slider (track + fill) used for volume / backlight.
Item {
  id: hudSlider
  property int value: 0
  property int maxValue: 100
  signal changed(int v)

  implicitWidth: 80
  implicitHeight: 10

  property bool hovered: false

  Rectangle {
    anchors.fill: parent
    radius: height / 2
    color: Colors.base01
  }

  Rectangle {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width * (hudSlider.value / hudSlider.maxValue)
    height: parent.height
    radius: height / 2
    color: hudSlider.hovered ? Colors.base0D : Colors.base0C
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: hudSlider.hovered = true
    onExited: hudSlider.hovered = false
    onClicked: function (mouse) {
      updateValue(mouse.x)
    }
    onPositionChanged: function (mouse) {
      if (pressed) updateValue(mouse.x)
    }

    function updateValue(x) {
      var v = Math.max(0, Math.min(hudSlider.maxValue, Math.round(x / hudSlider.width * hudSlider.maxValue)))
      hudSlider.value = v
      hudSlider.changed(v)
    }
  }
}
