import QtQuick 2.0
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4

Item {
    id: root
    width: 640
    height: 540

    Image {
        source: "qrc:/images/leaf/backgroundLeaves.jpg"
        anchors.fill: parent
    }
    ParticleSystem {
        anchors.fill: parent
        Emitter {
            width: parent.width
            emitRate: 4
            lifeSpan: 14000
            size: 80
            velocity: PointDirection { y: 160; yVariation: 80; xVariation: 20 }
        }

        ImageParticle {
            anchors.fill: parent
            id: particles
            sprites: [Sprite {
                    source: "qrc:/images/leaf/realLeaf1.png"
                    frameCount: 1
                    frameDuration: 1
                    to: {"a":1, "b":1, "c":1, "d":1}
                }, Sprite {
                    name: "a"
                    source: "qrc:/images/leaf/realLeaf1.png"
                    frameCount: 1
                    frameDuration: 10000
                },
                Sprite {
                    name: "b"
                    source: "qrc:/images/leaf/realLeaf2.png"
                    frameCount: 1
                    frameDuration: 10000
                },
                Sprite {
                    name: "c"
                    source: "qrc:/images/leaf/realLeaf3.png"
                    frameCount: 1
                    frameDuration: 10000
                },
                Sprite {
                    name: "d"
                    source: "qrc:/images/leaf/realLeaf4.png"
                    frameCount: 1
                    frameDuration: 10000
                }
            ]
            width: 100
            height: 100
            x: 20
            y: 20
            z:4
        }
        Friction {
            anchors.fill: parent
            anchors.margins: -40
            factor: 0.4
        }
    }
    Button{
        text:"return"
        anchors.bottom: parent.bottom
        width: 640
        onClicked: {root.visible = false}
    }
}
