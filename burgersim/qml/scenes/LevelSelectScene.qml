import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase {
    id: scene

    property string selected; //needed to communicate with game scene

    Background {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    signal playLevel

    Image {
        id: title
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        source: "../../assets/selectlevel.png"
    }

    LevelSelect {
        anchors.top: title.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10

        onPlayLevel: {
            selected = name;
            scene.playLevel(); //redirects the event to scene manager
        }
    }

}

