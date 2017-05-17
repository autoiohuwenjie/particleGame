import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    scale: 0.2
    property string ballColor: "green"
    Image {
        id: bug
        source: "qrc:/images/ballGame/ball.png"
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        opacity: 0.6
        visible: true
    }
    ColorOverlay {
        anchors.fill: bug
        source: bug
        opacity: 0.4
        color: ballColor
    }
}
