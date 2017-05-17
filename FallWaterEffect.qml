import QtQuick 2.5
import QtQuick.Particles 2.0


Rectangle{
    id: root
    color: "black"
    width: 640
    height: 540
    state:"hide"
    visible: false
    //先加载一个粒子系统
    ParticleSystem {
        id:sys
    }
    ImageParticle {
        system: sys
        source: "qrc:/images/glowdot.png"
        color: "white"
        colorVariation: 1.0
        alpha: 0.1
        entryEffect: ImageParticle.None
    }
    Emitter {
        id: emitter
        system: sys
        width: parent.width
        velocity: PointDirection {y: 72; yVariation: 24}
        acceleration: PointDirection {y: 72; yVariation: 24}
        lifeSpan: 10000
        emitRate: 300
        enabled: false
        size: 32
    }
    states: [
        State {
            name: "hide"
            PropertyChanges{target: root; visible: false}
        },
        State {
            name: "show"
            PropertyChanges{target: root; visible: true}
        }

    ]
    Transition{
        from:"hide"
        to:"show"
        reversible: true
        SequentialAnimation{
            PauseAnimation {duration: 2000}
            ScriptAction{script: {emitter.burst(1000);}}
            //此处的脚本没有被执行, 只能靠定时器触发
        }
    }
    Timer {
        interval: 500
        //triggeredOnStart: true
        running: true
        repeat: false
        onTriggered: {
            emitter.burst(1000);
        }
    }
    Component.onCompleted: {root.state = "show"}
}

