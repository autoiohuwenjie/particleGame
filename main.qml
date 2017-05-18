import QtQuick 2.5
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4
import "."


Item {
    id: root
    width: 640
    height: 540
    state:"hide"
    FireworkEffect{
        id:fireWorkEffect
        opacity: 0.0
        Item {
            id: menuAndPicture
            width: 640
            height: 540
            Image{
                source:"qrc:/images/welcome.png"
            }
            Column{
                anchors.centerIn: parent
                spacing: 10
                Button{
                    id: ballButton
                    objectName: "ballButton"
                    text:"Ball Shoting"
                    width: 200
                    x:100
                    onClicked: {

                    }
                }
                Button{
                    id: planeButton
                    text:"Shoting Plane"
                    width: 200
                    x:100
                    onClicked: {
                        shotPlane.visible = true;
                        menuAndPicture.visible = false;
                    }
                }
                Button{
                    id: leavesButton
                    text:"Leaves Story"
                    width: 200
                    x:100
                    onClicked: {
                        leafStory.visible = true;
                        menuAndPicture.visible = false;
                    }
                }
                Button{
                    id: quitButton
                    text:"QUIT"
                    width: 200
                    x:100
                    onClicked: {
                        Qt.quit();
                    }
                }
            }
        }
    }
    ShotPlane{
        id:shotPlane
        visible: false
        onVisibleChanged: {
            if(!visible){
                planeButton.enabled = true;
                menuAndPicture.visible = true;
            }
        }
    }
    LeafStory{
        id: leafStory
        visible: false
        onVisibleChanged: {
            if(!visible){
                leavesButton.enabled = true;
                menuAndPicture.visible = true;
            }
        }

    }
    FallWaterEffect{
        id:fallWaterEffect
        opacity: 1.0
    }
    Timer{
        interval: 5000
        repeat: false
        running: true
        onTriggered: {
            root.state = "show"
        }
    }//开场切换一次
    states: [
        State {
            name: "hide"
        },
        State {
            name: "show"
            PropertyChanges {target: fireWorkEffect; opacity: 1.0}
            PropertyChanges {target: fallWaterEffect; opacity: 0.0}
        },
        State {
            name: "BallShoting"
            PropertyChanges {target: fireWorkEffect; opacity: 0.0}
            PropertyChanges {target: fallWaterEffect; opacity: 0.0}

        },
        State {
            name: "shotPlane"
            PropertyChanges {target: fireWorkEffect; opacity: 0.0}
            PropertyChanges {target: fallWaterEffect; opacity: 0.0}
        }

    ]
    Transition {
        from: "hide"
        to: "show"
        SequentialAnimation{
            PauseAnimation{ duration: 2500}
            ParallelAnimation{
                NumberAnimation{target: fireWorkEffect; from:0.0; to:1.0; duration: 500}
                NumberAnimation{target: fallWaterEffect; from:1.0; to:0.0; duration: 500}
            }
        }
    }
    //Component.onCompleted: {root.state = "show"}这样就没有转换的的过程




}
