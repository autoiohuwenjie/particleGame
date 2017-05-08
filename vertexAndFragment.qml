import QtQuick 2.5

Rectangle{
    width:960;height: 480
    color:'#1e1e1e'
    Grid{
        anchors.centerIn: parent
        spacing: 20
        rows: 2; columns: 4
        Image {
            id: sourceImage
            width: 160; height: width
            source: "qrc:/image/texture.png"
        }
        ShaderEffect {
            id:effect1
            width: 160 ;height:width;
            visible: true
            vertexShader: "
              uniform highp mat4 qt_Matrix;
              attribute highp vec4 qt_Vertex;
              void main() {
                gl_Position = qt_Matrix * qt_Vertex;
              }
            "
            fragmentShader: "
              uniform lowp float qt_Opacity;
              void main() {
              gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0) * qt_Opacity;
              }"
        }
        ShaderEffect {
            id:effect2
            width: 160 ;height:width;
            property variant source: sourceImage
            visible: true
            fragmentShader: "
              varying highp vec2 qt_TexCoord0;
              uniform sampler2D source;
              uniform lowp float qt_Opacity;
              void main() {
                gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(1.0, 0.0, 0.0, 1.0) *qt_Opacity;
              }"
        }
        ShaderEffect {
            id:effect3
            width: 160 ;height:width;
            property variant source: sourceImage
            visible: true
            fragmentShader: "
              varying highp vec2 qt_TexCoord0;
              uniform sampler2D source;
              uniform lowp float qt_Opacity;
              void main() {
                gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(0.3, 1.0, 1.0, 1.0) *qt_Opacity;
              }"
        }
        ShaderEffect{
            id:effect4
            width: 160 ;height: width;
            property  variant source: sourceImage;
            property real redChannel: 0.3;
            visible: true
            NumberAnimation on redChannel {from:0.0; to: 1.0; loops:Animation.Infinite; duration: 4000}
            fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float redChannel;
            void main() {
              gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(redChannel, 1.0, 1.0, 1.0);

              }"
        }
    }
}
