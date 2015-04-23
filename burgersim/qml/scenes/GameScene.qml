import QtQuick 2.0
import VPlay 2.0
import "../common/data.js" as Data
import "../common"

SceneBase {
    id: scene
    property string currentLevel;
    property int timeLevel: 100

    signal timeElapsed()

    Background {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    Rectangle{
        id: timerBackground
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20



        width: 80
        height: 70

        radius: 10
        border.color: "#61d9e4"
        border.width: 3

        Text{
            id: timerText

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            property int time;

            font.pixelSize: parent.height-20

            text: time

            function reset() { timer.stop(); time = scene.timeLevel; }
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

                if(time<10){
                    color = "red"
                } else {
                    color = "black"
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
    }

    Rectangle{
        id: orderBackground
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        width: 150

        radius: 10
        border.color: "#61d9e4"
        border.width: 3

        Text{
            id: orderHeader
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            font.pixelSize: 20
            font.bold: true

            text: "Order: (1/30)"
        }
        Flickable {
            anchors.top: orderHeader.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins:5

            contentWidth: orderText.width; contentHeight: orderText.height

            clip:true

            flickableDirection: Flickable.VerticalFlick

            Text{
                id: orderText

                font.pixelSize: 20

                text: "- Top Bread\n- Hamburger\n- Salad\n- Bottom Bread\n- Top Bread\n- Hamburger\n- Salad\n- Bottom Bread\n- Top Bread\n- Hamburger\n- Salad\n- Bottom Bread"

                function reset() { text = "" } //resets means emptying order table for now...
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
        var lines = data.split("\n");
        lines = lines.filter(function(n){ return n != "" });

        Data.data = lines;

        //starting actual level
        timerText.start()
    }

    function reset()
    {
        timerText.reset();
        orderText.reset();
    }

    onCurrentLevelChanged: {
        if(currentLevel){
            loadLevel(currentLevel)
        } else {
            scene.reset()
        }
    }

}
