import QtQuick 2.0
import QtQuick.Particles 2.0
Item {
    id:root
    property real speed
    property real myangle
    property real originx
    property real originy
    property real emitRate
    property string particleColor: "red"
    property string pointerSrc:"qrc:/images/powerPointer.png"
    property string dotSrc:"qrc:/images/glowdot.png"

    ParticleSystem{
        id: sys
    }
    ImageParticle{
        system: sys
        groups: ["smoke"]
        source: dotSrc
        color: particleColor
        colorVariation: 0
    }
    Emitter{
    //可以近似看成坐标原点

        id:emitter
        anchors.centerIn: parent
        width: 5
        height: 5
        group: "smoke"
        system: sys
        emitRate: 800
        lifeSpan: 1800
        lifeSpanVariation: 500
        size:24
        endSize:8
        acceleration: PointDirection { y: -30 }
        velocity: AngleDirection { angle: 270; magnitude: 40; angleVariation: 20; magnitudeVariation: 5 }
        transform: Rotation {
            id: pointerRotationR
            origin.x: originx
            origin.y: originy
            angle:speed<90?myangle:360
            //angle:speed
            Behavior on angle { SpringAnimation { spring: 0.5; damping: 0.1; mass: 0.2; epsilon: 0.25} }
        }
    }
    Image {
        //因为针的图片有空白部分调整相对位置使针尖对准坐标原点
        x:-55
        y:-40
        id: speedPointer
        source: pointerSrc
        transform: Rotation {
            origin.x: 55
            origin.y: 330
            angle:speed<90?myangle:360
            //angle:speed
            Behavior on angle { SpringAnimation { spring: 0.5; damping: 0.1; mass: 0.2; epsilon: 0.25} }
        }
    }
}
