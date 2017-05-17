import QtQuick 2.0
import QtQuick.Particles 2.0


Rectangle {
    id: root
    width: 640
    height: 540
    color: "black"
    ParticleSystem{
        anchors.fill: parent
        id: sysFireWork
        ParticleGroup{
            name: "fire"
            duration: 2000
            durationVariation: 2000
            to: {"splode":1}//转换到下一个Group但是后面的数字没有看见明显意义
        }
        ParticleGroup{
            name: "splode"
            duration: 400
            to: {"dead":1}
            //伴随发射的小尾巴
            TrailEmitter {
                group: "works"
                emitRatePerParticle: 100
                lifeSpan: 1000
                maximumEmitted: 1200
                size: 8
                velocity: AngleDirection {angle: 270; angleVariation: 45; magnitude: 20; magnitudeVariation: 20;}
                acceleration: PointDirection {y:100; yVariation: 20}
            }
        }
        ParticleGroup{
            name: "dead"
            duration: 1000
            Affector {
                once: true
                onAffected: worksEmitter.burst(400,x,y)//后面跟着x，y才能在相关的位置爆炸, 参数代表爆炸的密集程度和范围
            }
        }
        Timer {
            interval: 5000
            running: true
            repeat: true
           // triggeredOnStart: true
            onTriggered: {
                startingEmitterLeft.pulse(300)
                startingEmitterRight.pulse(300)
            }
        }

        Emitter {
            id: startingEmitterLeft
            group: "fire"
            width: parent.width
            y: parent.height
            enabled: false
            emitRate: 80
            lifeSpan: 6000
            velocity: PointDirection {y:-200; x:100}//并不只代表方向数值越大，速度越快
            size:32
        }
        Emitter {
            id: startingEmitterRight
            group: "fire"
            width: parent.width
            y: parent.height
            enabled: false
            emitRate: 80
            lifeSpan: 6000
            velocity: PointDirection {y:-200; x:-100}//并不只代表方向数值越大，速度越快
            size:32
        }
        Emitter {
            id: worksEmitter
            group: "works"
            enabled: false
            emitRate: 100
            lifeSpan: 1600
            maximumEmitted: 6400
            size: 8
            velocity: CumulativeDirection {
                PointDirection {y:-100}
                AngleDirection {angleVariation: 360; magnitudeVariation: 80;}
            }
            acceleration: PointDirection {y:100; yVariation: 20}
        }

        ImageParticle {
            groups: ["fire","works", "splode"]
            source: "qrc:/images/glowdot.png"
            entryEffect: ImageParticle.Scale
            color: "red"
            colorVariation: 1.0
        }

    }
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
