import QtQuick 2.0
import VPlay 2.0
import "../common/data.js" as Data
import "../common"

SceneBase {
    id: scene
    property string currentLevel;
    property int timeLevel: 100
    property int totalBurgers: 0 //just default value
    property int currentBurger: 0 //just default value

    onCurrentBurgerChanged: {
        orderText.writeOrder();
    }

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
        anchors.bottom: validateButton.top
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

            text: "Order: ("+currentBurger.toString()+"/"+totalBurgers.toString()+")"
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

                text: "waiting order..." //should not be readable

                function reset() { text = "" } //resets means emptying order table for now...

                function writeOrder()
                {
                    if(currentBurger!=0){
                        reset(); //resetting order

                        var burgerData = Data.data[scene.currentBurger-1];

                        //parsing char per char and writing a readable order
                        for (var i=0, len = burgerData.length; i<len; i++) {
                            switch(burgerData[i]){
                                case 'b':
                                    text += "- Bottom bread\n"
                                    break;
                                case 'u':
                                    text += "- Upper bread\n"
                                    break;
                                case 'h':
                                    text += "- Hamburger\n"
                                    break;
                                case 'c':
                                    text += "- Cheese\n"
                                    break;
                                case 'k':
                                    text += "- Tomatoes\n"
                                    break;
                                case 's':
                                    text += "- Salad\n"
                                    break;
                                case 'B':
                                    text += "- Bacon\n"
                                    break;
                                case 'e':
                                    text += "- Eggs\n"
                                    break;
                            }
                        }

                        text = text.trim() //erasing last useless newline
                    }

                }

            }
        }
    }

    ImageButton {
        id: validateButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20

        source: "../../assets/trashbutton.png"

        onClicked: {
            console.log("trash current burger");
            currentBurger += 1
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

        //setting number of total burgers in level and current burger
        scene.totalBurgers = lines.length;
        scene.currentBurger = 1;

        //starting actual level
        timerText.start();
    }

    function reset()
    {
        timerText.reset();
        orderText.reset();
        totalBurgers = 0;
        currentBurger = 0;
    }

    onCurrentLevelChanged: {
        if(currentLevel){
            loadLevel(currentLevel)
        } else {
            scene.reset()
        }
    }

}
