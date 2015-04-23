import QtQuick 2.0

ImageButton {
    property string name;
    source: "../../assets/"+name+".png"

    onClicked: {
        playLevel(name+".txt")
    }
}
