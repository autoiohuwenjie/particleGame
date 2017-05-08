import QtQuick 2.5

Rectangle{
    width: 960; height: 480;
    color: "#1e1e1e"
    Image {
        id: sourceImage
        source: "qrc:/image/texture.png"
        visible: false
    }
    Rectangle{
        width: 160; height:  width;
        anchors.centerIn: parent
        color: "#333333"
    }
    ShaderEffect{
        id: genieEffect
        width: 160; height: width;
        anchors.centerIn: parent
        property variant source: sourceImage
        property real minimize: 0.0 ;
        mesh: GridMesh { resolution: Qt.size(16, 16)}
        SequentialAnimation on minimize {
            NumberAnimation { to: 1.0; duration: 1800; easing.type:Easing.InOutSine }
            PauseAnimation { duration: 1000 }
            NumberAnimation { to: 0.0; duration: 1800; easing.type:Easing.InOutSine }
            loops:Animation.Infinite;
        }
        //缩小的插值算法
//        vertexShader: "
//        uniform highp mat4 qt_Matrix;
//        attribute highp vec4 qt_Vertex;
//        attribute highp vec2 qt_MultiTexCoord0;
//        varying highp vec2 qt_TexCoord0;
//        uniform highp float minimize;
//        uniform highp float width;
//        uniform highp float height;
//        void main() {
//          qt_TexCoord0 = qt_MultiTexCoord0;
//          highp vec4 pos = qt_Vertex;
//          highp float t = pos.y / height;
//          t = (3.0 - 2.0 * t) * t * t;
//          pos.y = mix(qt_Vertex.y, 0.0, minimize);
//          pos.x = mix(qt_Vertex.x, 0.0, t * minimize);//顶点原点坐标系在左上角
//          gl_Position = qt_Matrix * pos;
//          }"

       //两边同时曲线收缩
        vertexShader: "
        uniform highp mat4 qt_Matrix;
        attribute highp vec4 qt_Vertex;
        attribute highp vec2 qt_MultiTexCoord0;
        varying highp vec2 qt_TexCoord0;
        uniform highp float minimize;
        uniform highp float width;
        uniform highp float height;
        void main() {
          qt_TexCoord0 = qt_MultiTexCoord0;
          highp vec4 pos = qt_Vertex;
          highp float t = pos.y / height;
          t = sin( t * 3.1415926 / 2.0);
          pos.x= mix(qt_Vertex.x, width/2.0, t * minimize);
            gl_Position = qt_Matrix * pos;
           }
        "
    }
}
