import VPlay 2.0
import QtQuick 2.0

//keep row in case we want to extend this and add buttons
Row {
    signal playPressed()

    spacing: 18
    height: menuItem.height

    ImageButton {
        id: menuItem

        onClicked: {
            //triggers the play pressed signal that communicates with the scene manager
            playPressed()
        }
        source: "../../assets/play.png"
    }
}

