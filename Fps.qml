import QtQuick 2.6

Item {
    id: root
    width: 125
    height: 48
    property int fps: 60
    property int frameCounter: 0
    property string fontFamily: ""
    onFontFamilyChanged: {
        fpsText.font.family = root.fontFamily;
    }

    Item {
        id: spinnerImage
        NumberAnimation on rotation {
            from:0
            to: 360
            duration: 1000
            loops: Animation.Infinite
        }
        onRotationChanged: {
            ++frameCounter;
        }
    }

    Text {
        id: fpsText
        text: root.fps + " fps"
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
        font.pixelSize: 24
        anchors.centerIn: parent
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            fps = frameCounter;
            frameCounter = 0;
        }
    }
}
