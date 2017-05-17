import QtQuick 2.5
import "./common"
import "."
Item {
    id: root
    width: 1024
    height: 768
    Image{
        id: backgroundPic
        width: 1024
        height: 768
        source: "qrc:/images/ballGame/ballBackground.jpg"
        Image {
            id: direction
            anchors.centerIn: parent
            scale: 1.2
            source: "qrc:/images/ballGame/direction.png"
        }
    }
    Component {
        id: myKnife
        Image {
            id: knifeImage
            scale: 0.2
            x: 380
            y: 560
            source: "qrc:/images/ballGame/littleknife.png"
            property real targetX: 512
            property real targetY: -100
            property real moveTime: 3000
            function go(){
                knifeImage.enabled = true;
                animX.start();
                animY.start();
                rotationAnim.start();
            }
            NumberAnimation on x{id: animX; to:knifeImage.targetX; duration: knifeImage.moveTime; easing.type: Easing.OutQuad; running:false}
            NumberAnimation on y{id: animY; to:knifeImage.targetY; duration: knifeImage.moveTime; easing.type: Easing.OutQuad; running:false}
            SequentialAnimation on rotation{
                id:rotationAnim;
                NumberAnimation  { to:3240; duration: 1500}
                NumberAnimation  { to:0; duration: 1500}
                loops: Animation.Infinite

            }
            Timer {
                interval: knifeImage.moveTime + 500;
                running: true
                onTriggered: knifeImage.destroy();
            }
        }
    }
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
        //创造泡泡
        function createBubble(num){
            for(var i = 0; i <= num; i++)
            {

            }
        }
        //开火
        function fire(angle) {
            var obj = myKnife.createObject(root);//(400,-200)这是调整好的基础位置，在舵的中心
            var arcAngle = Math.PI / 180.0 *angle
            obj.targetX = 380 + Math.sin(arcAngle) * 1080;
            obj.targetY = 560 - Math.abs(Math.cos(arcAngle)) * 1080;
            obj.go();
        }
        Keys.onPressed: {
            switch(event.key) {
            case Qt.Key_Left:
                if(helmAndKnife.myAngle >= -85 )
                    helmAndKnife.myAngle -= 5;
                break;
            case Qt.Key_Right:
                if(helmAndKnife.myAngle <= 85 )
                    helmAndKnife.myAngle += 5;
                break;
            case Qt.Key_Up:
                fire(helmAndKnife.myAngle);
                break;
            case Qt.Key_Space:
                fire(helmAndKnife.myAngle);
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

}

