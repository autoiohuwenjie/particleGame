import QtQuick 2.5

Item{
    width: 299; height: 299;
    Image {
        id: sourceImage
        source: "qrc:/image/speedline.png"
        visible: false
    }
    ShaderEffect{
        id: genieEffect
        width: 299; height: 299;
        anchors.verticalCenter: parent.verticalCenter
        property variant source: sourceImage
        //角度范围（15, 148）
        property real mRot: 89;
        property real radRot: mRot / 180 * Math.PI
        property real centerX: 0.5 + 0.0468
        property real centerY: 0.5 - 0.0435
        mesh: GridMesh { resolution: Qt.size(1, 1)}
//        SequentialAnimation on mRot {
//            NumberAnimation { to: -30; duration: 1800; easing.type:Easing.InOutSine }
//            PauseAnimation { duration: 1000 }
//            NumberAnimation { to: 160; duration: 1800; easing.type:Easing.InOutSine }
//            loops:Animation.Infinite;
//        }
        fragmentShader: "
        uniform lowp float centerX;
        uniform lowp float centerY;
        uniform lowp float radRot;
        varying lowp vec2 qt_TexCoord0;
        uniform sampler2D source;
        void main() {
          lowp float coordRad;
          if(qt_TexCoord0.x <= centerX) {
            coordRad = atan((centerY - qt_TexCoord0.y),(centerX - qt_TexCoord0.x)) + 1.5707963267949;
          }else {
            coordRad = atan((qt_TexCoord0.y - centerY),(qt_TexCoord0.x - centerX)) - 1.5707963267949;
          }
          lowp float factor = 1.0;
          if(radRot >= coordRad && radRot < coordRad + 0.02)
          {
            factor = (coordRad - radRot) * 70.0 ;
          }
          if(radRot < coordRad)
          {
            discard;
          }
          gl_FragColor = texture2D(source, qt_TexCoord0) * (1.0, 1.0, 1.0, factor);
        }"
    }
}
