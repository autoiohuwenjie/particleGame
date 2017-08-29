import QtQuick 2.5

Item{
    //ringCut边缘波动函数例子
    width: 688; height: 688;
    Image {
        id: sourceImage
        source: "qrc:/image/powerLineRed.png"
        visible: false
    }
    Rectangle{
        width: 348; height:  348;
        anchors.verticalCenter: parent.verticalCenter
        color: "#333333"
    }
    ShaderEffect{
        id: genieEffect
        width: 348; height: 348;
        anchors.verticalCenter: parent.verticalCenter

        property variant source: sourceImage

        property real mRot: 120
        property real mRRot: tranfromAngle(mRot)

        property real amplitude: 0.06;
        property real cycle: 0;
        property real offsetZ: tranfromAngle(20);

        function tranfromAngle(angle) {
            return angle / 180 * 3.1415926;
        }

        mesh: GridMesh { resolution: Qt.size(1, 1)}
        SequentialAnimation on mRot {
            NumberAnimation { to: 30; duration: 5000; easing.type: Easing.InOutSine}
            PauseAnimation { duration: 200 }
            NumberAnimation { to: 130; duration: 5000; easing.type: Easing.InOutSine}
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
                SequentialAnimation {
                    ScriptAction {script: {genieEffect.amplitude = 0.06}}
                    NumberAnimation {target: genieEffect; property: "amplitude"; to: 0; duration: 5600}
                }
            }
        }

        fragmentShader: "
        uniform lowp float mRRot;
        uniform lowp float amplitude;
        uniform lowp float cycle;
        uniform lowp float offsetZ;


        varying lowp vec2 qt_TexCoord0;
        uniform sampler2D source;
        void main() {
          lowp float rad = mRRot - amplitude * sin( 8.0 * distance(vec2(0.0, 0.5), vec2(qt_TexCoord0.x, qt_TexCoord0.y)) + offsetZ);
          lowp float coordRad = atan((qt_TexCoord0.x),(qt_TexCoord0.y-0.5));
          lowp float factor = 1.0;
          if( coordRad < rad && coordRad >= rad - 0.01)
          {
            factor = (mRRot - coordRad) * 16.0 ;
          }
          if(rad < coordRad)
          {
            discard;
          }
          gl_FragColor = texture2D(source, qt_TexCoord0) * (1.0, 1.0, 1.0, factor);
        }"
    }
}
