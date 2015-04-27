import VPlay 2.0
import QtQuick 2.0
import "scenes"
import "common"
import "entities"

Item {
    id: mainItem

    EntityManager {
        id: entityManager
        entityContainer: gameScene
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

        onPlayLevel: {
            mainItem.state = "game"
        }
    }


    WinScene {
        id: winScene

        onBackButtonPressed: {
            mainItem.state = "menu"
        }
    }

    LoseScene {
        id: loseScene

        onBackButtonPressed: {
            mainItem.state = "menu"
        }
    }

    GameScene {
        id: gameScene

        onBackButtonPressed: {
            nativeUtils.displayMessageBox("Abort the level?", "", 2);
        }

        Connections {
            // nativeUtils should only be connected, when this is the active scene
            target: window.activeScene === gameScene ? nativeUtils : null
            onMessageBoxFinished: {
                if(accepted) {
                    mainItem.state = "levelselect"
                }
            }
        }

        onTimeElapsed: {
            mainItem.state = "lose"
        }

        onLevelEnded: {
            mainItem.state = "win"
        }
    }

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
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
            PropertyChanges {target: gameScene; currentLevel: levelSelectScene.selected}
        },
        State {
            name: "win"
            PropertyChanges {target: winScene; opacity: 1}
            PropertyChanges {target: window; activeScene: winScene}
        },
        State {
            name: "lose"
            PropertyChanges {target: loseScene; opacity: 1}
            PropertyChanges {target: window; activeScene: loseScene}
        }
    ]
}

