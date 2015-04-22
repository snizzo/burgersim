import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase {
    id: scene

    signal gamePressed()
    signal networkPressed()

    Background {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    Image {
        anchors.fill: parent
        source: "../../assets/mainmenu.png"
    }

    Menu {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter

        onPlayPressed: gamePressed()
    }

    onEnterPressed: {
        gamePressed()
    }
}

