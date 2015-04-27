import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase {
    id: scene

    Background {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    Image{
        anchors.fill: parent

        source: "../../assets/lose.png"
    }
}
