import QtQuick 2.8

Item{
    //ringCut边缘波动函数例子
    property int mWidth: 500
    property int mHeight: 500
    property bool mVisible: true
    property int mX
    property int mY
    property int mZ
    visible: mVisible
    x: mX; y: mY; z: mZ
    width: mWidth; height: mHeight
    Image {
        id: sourceImage
        source: "qrc:/image/powerLineRed.png"
        visible: false
    }
    ShaderEffect{
        id: genieEffect
        width: mWidth; height: mWidth;
        anchors.verticalCenter: parent.verticalCenter

        property variant source: sourceImage

        property real mRot: 120
        property real mRRot: tranfromAngle(mRot)

        property real amplitude: 0.06;
        property real offsetZ: tranfromAngle(20);

        function tranfromAngle(angle) {
            return angle / 180 * 3.1415926;
        }

        mesh: GridMesh { resolution: Qt.size(1, 1)}
        SequentialAnimation on mRot {
            NumberAnimation { to: 60; duration: 5000; easing.type: Easing.InOutSine}
            PauseAnimation { duration: 200 }
            NumberAnimation { to: 90; duration: 5000; easing.type: Easing.InOutSine}
            loops: Animation.Infinite;
        }
        onMRotChanged: {
            fluctuationAnim.start();
        }

        SequentialAnimation {
            id: fluctuationAnim
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation {target: genieEffect; property: "offsetZ"; to: 0; duration: 600; easing.type: Easing.InOutSine}
                    NumberAnimation {target: genieEffect; property: "offsetZ"; to: 8; duration: 700; easing.type: Easing.InOutSine}
                    NumberAnimation {target: genieEffect; property: "offsetZ"; to: 0; duration: 800; easing.type: Easing.InOutSine}
                    NumberAnimation {target: genieEffect; property: "offsetZ"; to: 8; duration: 900; easing.type: Easing.InOutSine}
                    NumberAnimation {target: genieEffect; property: "offsetZ"; to: 0; duration: 1000; easing.type: Easing.InOutSine}
                }
            }
        }

        fragmentShader: "
        uniform lowp float mRRot;
        uniform lowp float amplitude;
        uniform lowp float offsetZ;


        varying lowp vec2 qt_TexCoord0;
        uniform sampler2D source;
        void main() {
          lowp float rad = mRRot - amplitude * sin( 8.0 * distance(vec2(0.0, 0.5), vec2(qt_TexCoord0.x, qt_TexCoord0.y)) + offsetZ);
          lowp float coordRad = atan((qt_TexCoord0.x),(qt_TexCoord0.y-0.5));
          lowp float factor = 1.0;
          if( coordRad < rad && coordRad >= rad - 0.006)
          {
            factor = (mRRot - coordRad) * 12.0 ;
          }
          if(rad < coordRad)
          {
            discard;
          }
          gl_FragColor = texture2D(source, qt_TexCoord0) * (1.0, 1.0, 1.0, factor);
        }"
    }
}
