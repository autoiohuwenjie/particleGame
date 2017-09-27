import QtQuick 2.5

ShaderEffect{
    id: root
    width: 250; height: 250
    Image {
        id: sourceImage
        visible: false
        width: root.width; height: root.height
        source: "qrc:/image/waterLines.png"
    }
    mesh: GridMesh { resolution: Qt.size(1, 1) }
    property variant source: sourceImage;
    property real frequency: 8;
    property real amplitude: 0.05;
    property real time: 0.0;
    NumberAnimation on time {
        from: 0; to: Math.PI*2; duration: 1000; loops: Animation.Infinite
    }
    vertexShader: "
            uniform highp mat4 qt_Matrix;
            attribute highp vec4 qt_Vertex;
            attribute highp vec2 qt_MultiTexCoord0;
            varying highp vec2 qt_TexCoord0;
            uniform highp float minimize;
            uniform highp float width;
            uniform highp float height;
            uniform highp int direction;
            void main() {
                qt_TexCoord0 = qt_MultiTexCoord0;
//                highp vec4 pos = qt_Vertex;
//                if(direction == 0 || direction == 1){
//                  highp float t = pos.y / height;
//                  if(direction == 0){
//                    pos.x = mix(qt_Vertex.x, width / 2.0, ( 1.0 - t ) * minimize);
//                  }else{
//                    pos.x = mix(qt_Vertex.x, width / 2.0,  t * minimize);
//                  }
//                }else if(direction == 2 || direction == 3){
//                  highp float t = pos.x / width;
//                  if(direction == 2){
//                    pos.y = mix(qt_Vertex.y, height / 2.0, ( 1.0 - t)  * minimize);
//                  }else{
//                    pos.y = mix(qt_Vertex.y, height / 2.0, t * minimize);
//                  }
//                }
                gl_Position = qt_Matrix * qt_Vertex;
            }"
    fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            uniform highp float frequency;
            uniform highp float amplitude;
            uniform highp float time;
            void main() {
              highp vec2 pulse = sin(time - frequency * qt_TexCoord0);
              if(qt_TexCoord0.x > 0.5) {
                  pulse= vec2(0.0, 0.0);
              }
              highp vec2 coord = qt_TexCoord0 + amplitude * vec2(pulse.x, 0);
              gl_FragColor =texture2D(source, coord) * qt_Opacity;
              }"
}

