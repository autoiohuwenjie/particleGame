import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    scale: 0.4
    property string ballColor: "green"
    Image {
        id: bug
        source: "qrc:/images/ballGame/smallball.png"
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        visible: false
    }
    ColorOverlay {
        anchors.fill: bug
        source: bug
        opacity: 0.6
        color: ballColor
    }
}
