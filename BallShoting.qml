import QtQuick 2.5
import "./common"
import "."
Item {
    id: root
    width: 1024
    height: 1024
    Item {
        id: helmAndKnife
        x: 412
        y: 560
        width: 200
        height: 200
        focus: true;//需要获得焦点才有处理信号的权利
        property real myAngle: 0
        Image {
            id: deathKnife
            x: 42
            y: 45
            width: 100
            height: 100
            rotation: 36
            clip: true
            source: "../images/ballGame/deathKnife.png"
        }

        Image {
            id: helm
            x: 50
            y: 101
            width: 100
            height: 100
            source: "../images/ballGame/helm.png"
        }
        transform: Rotation{origin.x:100; origin.y: 150; angle: helmAndKnife.myAngle}//范围为-90到90

        function rotate(angle){
            if(helmAndKnife.myAngle <= 87 ||helmAndKnife.myAngle >= -87 )
                helmAndKnife.myAngle += angle
        }
        Keys.onPressed: {
            switch(event.key) {
            case Qt.Key_Left:
                helmAndKnife.myAngle -= 5;
                break;
            case Qt.Key_Right:
                helmAndKnife.myAngle += 5;
                break;
            case Qt.Key_Up:
                helmAndKnife.myAngle -= 10;
                break;
            case Qt.Key_Down:
                helmAndKnife.myAngle += 10;
                break;
            default:
                return;
            }
            event.accepted = true;//防止把信号继续传递下去
        }
    }
    //    MouseArea{
    //        anchors.fill: parent
    //        onClicked: {helmAndKnife.myAngle += -3}
    //    }
}

