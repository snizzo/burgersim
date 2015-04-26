import QtQuick 2.0
import VPlay 2.0

EntityBase {
    entityType: "ingredient"

    property alias source: image.source

    Image{
        id: image
        smooth: false
        scale: 4
    }
}

