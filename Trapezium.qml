import QtQuick 2.6

ShaderEffect{
    id: genieEffect
    width: 250
    height: 250
    mesh: GridMesh { resolution: Qt.size(16, 16) }    //默认是2*2使用此改成16*16网格
    anchors.centerIn: parent

    property string src: "qrc:/image/texture.png"
    property variant source: sourceImage
    property int direction : 2                        //(0,1,2,3对应上下左右)
    property real minimize: 0                         //缩小的尺寸,0不变,1变三角
    SequentialAnimation on minimize {
        PauseAnimation { duration: 300 }
        NumberAnimation { to: 0.6; duration: 700; easing.type: Easing.InOutSine }
        NumberAnimation { to: 0; duration: 700; easing.type: Easing.InOutSine }
        loops: Animation.Infinite
    }
    Image {
        id: sourceImage
        source: src
        visible: false
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
                highp vec4 pos = qt_Vertex;
                if(direction == 0 || direction == 1){
                  highp float t = pos.y / height;
                  if(direction == 0){
                    pos.x = mix(qt_Vertex.x, width / 2.0, ( 1.0 - t ) * minimize);
                  }else{
                    pos.x = mix(qt_Vertex.x, width / 2.0,  t * minimize);
                  }
                }else if(direction == 2 || direction == 3){
                  highp float t = pos.x / width;
                  if(direction == 2){
                    pos.y = mix(qt_Vertex.y, height / 2.0, ( 1.0 - t)  * minimize);
                  }else{
                    pos.y = mix(qt_Vertex.y, height / 2.0, t * minimize);
                  }
                }
                gl_Position = qt_Matrix * pos;
            }"
}
