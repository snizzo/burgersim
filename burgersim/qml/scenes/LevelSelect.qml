import QtQuick 2.0

Grid {
    columns: 4
    spacing: 10

    signal playLevel(string name)

    LevelButton {
        name: "level1"
    }
    LevelButton{
        name: "level2"
    }
    LevelButton{
        name: "level3"
    }
    LevelButton{
        name: "level4"
    }
    LevelButton{
        name: "level5"
    }
    LevelButton{
        name: "level6"
    }
    LevelButton{
        name: "level7"
    }
    LevelButton{
        name: "level8"
    }
    LevelButton{
        name: "level9"
    }
    LevelButton{
        name: "level10"
    }





    /*
      TODO: implement endless?
    ImageButton {
        source: "../../assets/endless.png"
    }
    */
}

