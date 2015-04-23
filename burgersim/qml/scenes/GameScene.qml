import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase {
    id: scene
    property string currentLevel;
    property int timeLevel: 10

    signal timeElapsed()

    Background {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    Image {
        id: title
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        source: "../../assets/timer.png"
    }

    Text{
        id: timerText

        property int time;

        anchors.left: title.right
        anchors.verticalCenter: title.verticalCenter
        font.pixelSize: title.height

        text: time

        function reset() { time = parent.timeLevel; }
        function start() { reset(); timer.start() }

        //do very first reset
        Component.onCompleted: {
            reset()
        }

        //checks every second if it is 0
        //if it is, stop the timer and says scene manager time is over
        onTimeChanged: {
            if(time==0){
                timer.stop()
                timeElapsed()
            }
        }

        Timer {
            id: timer
            interval: 1000; running: false; repeat: true
            onTriggered: {
                parent.time -= 1
            }
        }
    }

    /*
        This function loads a level reading a txt file describing how burgers are composed.
        It shows how to read-access human readable files via qml without c++, using xmlhttprequest,
        in order to load custom not hardcoded data
    */
    function loadLevel(name){
        var xhr = new XMLHttpRequest;
        xhr.open("GET", "../../assets/levels/"+name);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                parseLevel(xhr.responseText);
            }
        }
        xhr.send();
    }

    function parseLevel(data){
        //parse txt file and put it into data,
        //then do interface and build burger and
        //validate burger and won level

        //once loaded, start timer
        timer.start()
    }

    onCurrentLevelChanged: {
        if(currentLevel){
            loadLevel(currentLevel)
        }
    }

}
