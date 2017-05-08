import QtQuick 2.5

Rectangle{
    width: 960; height: 480
    color: "#1e1e1e"
    Row {
        anchors.centerIn: parent
        spacing: 20;
        Image {
            id: sourceImage
            width: 160; height: width;
            source: "qrc:/image/texture.png"
        }
        ShaderEffect{
            width: 160; height: width
            property variant source: sourceImage;
            property real frequency: 8;
            property real amplitude: 0.05;
            property real time: 0.0;
            NumberAnimation on time {
                from: 0; to: Math.PI*2; duration: 1000; loops: Animation.Infinite
            }
            fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            uniform highp float frequency;
            uniform highp float amplitude;
            uniform highp float time;
            void main() {
              highp vec2 pulse = sin(time - frequency * qt_TexCoord0);
              highp vec2 coord = qt_TexCoord0 + amplitude * vec2(pulse.x, -pulse.x);
              //highp vec2 coord = qt_TexCoord0 +amplitude * vec2(5, 10);
              gl_FragColor =texture2D(source, coord) * qt_Opacity;
              }"
        }
    }
}
