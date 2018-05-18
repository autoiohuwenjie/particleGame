import QtQuick 2.5
import "./common" as Js


Rectangle {
    visible: true
    width: 1000
    height: 800
    color: "black"

    Image {
        id: speedDial
        source: "qrc:/images/powerDral.png"
    }

    Js.Particle{
        id:part
        x:320
        y:50
        myangle:0
        originx:2.5
        originy:290
        SequentialAnimation on speed {
            NumberAnimation{duration: 1000;to:180;}
            NumberAnimation{duration: 1000;to:0;}
            loops:Animation.Infinite
        }
    }
    //注意点两点
    //1 把喷射器当做一个整体的后果如下，原因因为跨了一个qml文件那么原本的加速度和速度的方向就不对了，角度必须在原本的文件内改
    //2 在main中使用NumberAnimation对于属性连续的修改会导致原qml内的动画来不及触发，所以信号直接绑定在原本的qml内部
//    Item {
//        id:myItem
//        x:330
//        y:55
//        property real myAngle : 0.0
//        Js.Particle{
//        }
//        transform: Rotation{origin.x:55;origin.y:330;angle: myItem.myAngle}
//        SequentialAnimation on myAngle {
//            NumberAnimation{duration: 5000;to:180}
//            loops: Animation.Infinite
//        }
//    }

}



