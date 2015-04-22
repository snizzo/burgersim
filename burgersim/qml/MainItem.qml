import VPlay 2.0
import QtQuick 2.0
import "scenes"
import "common"

Item {
    id: mainItem
    property alias audioManager: audioManager

    // global music and sound management
    AudioManager {
        id: audioManager
    }

    MenuScene {
        id: menuScene
        onGamePressed: {
            mainItem.state = "levelselect"
        }

        onBackButtonPressed: {
            nativeUtils.displayMessageBox("Really quit the game?", "", 2);
        }

        Connections {
            // nativeUtils should only be connected, when this is the active scene
            target: window.activeScene === menuScene ? nativeUtils : null
            onMessageBoxFinished: {
                if(accepted) {
                    Qt.quit()
                }
            }
        }
    }



    LevelSelectScene {
        id: levelSelectScene

        onBackButtonPressed: {
            mainItem.state = "menu"
        }

        /*
        onMenuPressed: {
            mainItem.state = "menu"
        }
        onNetworkPressed: {
            vplayGameNetworkScene.initialStateBeforeShow = "game"
            mainItem.state = "gameNetwork"
        }
        onUseCoinsPressed: {
        }
        */
    }


    /*
    GameScene {
        id: gameScene

        onMenuPressed: {
            mainItem.state = "menu"
        }
        onNetworkPressed: {
            vplayGameNetworkScene.initialStateBeforeShow = "game"
            mainItem.state = "gameNetwork"
        }
        onUseCoinsPressed: {
        }
    }
    */

    state: "menu"

    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
            StateChangeScript {
                script: {
                    //audioManager.play(audioManager.idSWOOSHING)
                }
            }
        },
        State {
            name: "levelselect"
            PropertyChanges {target: levelSelectScene; opacity: 1}
            PropertyChanges {target: window; activeScene: levelSelectScene}
        }
    ]
}

