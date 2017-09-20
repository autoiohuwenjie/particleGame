import QtQuick 2.5

Item{
    width: 688; height: 688;
    Image {
        id: sourceImage
        source: "qrc:/image/speedline.png"
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
        property real mRot: 90;
        mesh: GridMesh { resolution: Qt.size(1, 1)}
        SequentialAnimation on mRot {
            NumberAnimation { to: 10; duration: 1800; easing.type:Easing.InOutSine }
            PauseAnimation { duration: 1000 }
            NumberAnimation { to: 160; duration: 1800; easing.type:Easing.InOutSine }
            loops:Animation.Infinite;
        }

        fragmentShader: "
        uniform lowp float mRot;
        varying lowp vec2 qt_TexCoord0;
        uniform sampler2D source;
        void main() {
          lowp float rad = 3.1419526 * mRot / 180.0;
          lowp float coordRad = atan((1.0 - qt_TexCoord0.x),(0.5 - qt_TexCoord0.y));
          lowp float factor = 1.0;
          if(rad <= coordRad && rad > coordRad - 0.02)
          {
            factor = (coordRad - rad) * 50.0 ;
          }
          if(rad > coordRad)
          {
            discard;
          }
          gl_FragColor = texture2D(source, qt_TexCoord0) * (1.0, 1.0, 1.0, factor);
        }"
    }
}
