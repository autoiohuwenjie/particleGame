import QtQuick 2.5
import QtQuick.Particles 2.0

Rectangle {
    id: root
    color: "black"
    width: 640
    height: 540
    ParticleSystem{
        id: sys
    }
    ImageParticle{
        system: sys
        source: "qrc:/images/glowdot.png"
        color: "white"
        colorVariation: 1.0
        alpha: 0.1
    }

    Component{
        id: emitterComp
        Emitter{
            id: container
            Emitter{
                id: emitMore
                system: sys
                emitRate: 128
                lifeSpan: 600
                size: 16
                endSize: 8
                velocity: AngleDirection {angleVariation: 360; magnitude: 60}//梯度决定啦范围
            }
            property int life: 2600
            property real targetX: 0
            property real targetY: 0
            system: sys
            emitRate: 1000
            lifeSpan: life
            size: 32
            endSize: 6
            function go() {
                container.enabled = true
                animX.start();
                animY.start();
            }
            NumberAnimation on x{id: animX; to: targetX; duration: life; running: false}//running为false，但是如果start之后running自动变成enbled
            NumberAnimation on y{id: animY; to: targetY; duration: life; running: false}
            Timer{
                interval:life
                running: true
                onTriggered: container.destroy();
            }
        }
    }
    function customClick(x,y){
      for (var i = 0;i <= 12; ++i) {
      var obj = emitterComp.createObject(root);
      obj.x = x;
      obj.y = y;
      obj.targetX = Math.random() * 80 - 40 + obj.x;
      obj.targetY = Math.random() * 80 - 40 + obj.y;
      obj.life = Math.round(Math.random() * 1200);
      obj.emitRate = Math.round(Math.random() * 12) ;
      obj.go();
      }
    }
    MouseArea {
        anchors.fill: root;
        onClicked: customClick(mouseX,mouseY);
    }

}
