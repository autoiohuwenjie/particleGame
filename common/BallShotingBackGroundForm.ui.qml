import QtQuick 2.4

Item {
    width: 1024
    height: 768



    Item {
        id: item1
        x: 412
        y: 568
        width: 200
        height: 200

        Image {
            id: image2
            x: 42
            y: 45
            width: 100
            height: 100
            rotation: 36
            clip: true
            source: "../images/ballGame/deathKnife.png"
        }

        Image {
            id: image1
            x: 50
            y: 101
            width: 100
            height: 100
            source: "../images/ballGame/helm.png"
        }

    }
}
