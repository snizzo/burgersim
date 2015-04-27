import QtQuick 2.0
import VPlay 2.0
import "../common/data.js" as Data
import "../common"
import "../entities"

SceneBase {
    id: scene
    property string currentLevel;
    property int timeLevel: 150
    property int totalBurgers: 0 //just default value
    property int currentBurger: 0 //just default value
    property string rightBurger: ""
    property string codedBurger: ""

    onCurrentBurgerChanged: {
        console.log(currentBurger)
        if(currentBurger > totalBurgers) {
            levelEnded();
        } else {
            orderText.writeOrder();
        }
    }

    signal timeElapsed()
    signal levelEnded()

    Background {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    Image{
        id:lose

        anchors.fill: parent
        z:1
        visible:false

        source: "../../assets/lose.png"
    }

    Rectangle{
        id: timerBackground
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20



        width: 120
        height: 60

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

                        if(burgerData!=undefined){
                            rightBurger = burgerData

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
                                        text += "- Ketchup\n"
                                        break;
                                    case 't':
                                        text += "- Tomato\n"
                                        break;
                                    case 's':
                                        text += "- Salad\n"
                                        break;
                                    case 'a':
                                        text += "- Bacon\n"
                                        break;
                                    case 'e':
                                        text += "- Eggs\n"
                                        break;
                                }
                            }
                        }

                        text = text.trim() //erasing last useless newline if present
                    }

                }

            }
        }
    }

    Rectangle{
        id: ingredientsBackground
        anchors.left: timerBackground.left
        anchors.top: timerBackground.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: timerBackground.right

        width: 150

        radius: 10
        border.color: "#61d9e4"
        border.width: 3

        Grid{
            anchors.fill: parent
            anchors.margins: 10
            columns: 2
            spacing: 2

            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/a_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("a")
                    }
                }
            }
            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/b_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("b")
                    }
                }
            }
            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/c_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("c")
                    }
                }
            }
            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/e_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("e")
                    }
                }
            }
            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/h_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("h")
                    }
                }
            }
            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/k_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("k")
                    }
                }
            }
            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/s_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("s")
                    }
                }
            }
            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/t_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("t")
                    }
                }
            }
            Image{
                width: parent.width/2
                height: parent.height/5
                source: "../../assets/ingredients/u_icon.png"
                smooth: false
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        addIngredient("u")
                    }
                }
            }
        }
    }

    ImageButton {
        id: validateButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: orderBackground.horizontalCenter

        width:100


        state: "trash"

        states: [
            State {
                name: "trash"
                when: (codedBurger != rightBurger)
                PropertyChanges {target: validateButton; source: "../../assets/trashbutton.png"}
            },
            State {
                name: "send"
                when: (codedBurger == rightBurger)
                PropertyChanges {target: validateButton; source: "../../assets/okbutton.png"}
            }
        ]

        onClicked: {    
            if(state=="trash"){
                entityManager.removeAllEntities();
                codedBurger = "";
            } else if(state=="send") {
                entityManager.removeAllEntities();
                currentBurger += 1;
            }

            codedBurger = "";
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

    function addIngredient(ingredient)
    {
        codedBurger += ingredient;
        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../../qml/entities/Ingredient.qml"),
                    {
                        entityId: "ingredient"+codedBurger.length.toString(),
                        x:220,
                        y:250-12*codedBurger.length,
                        source:"../../../assets/ingredients/"+ingredient+".png"
                    })
    }

    function reset()
    {
        timerText.reset();
        orderText.reset();
        totalBurgers = 0;
        currentBurger = 0;
        codedBurger = "";

    }

    onCurrentLevelChanged: {
        if(currentLevel){
            loadLevel(currentLevel)
        } else {
            scene.reset()
        }
    }

}
