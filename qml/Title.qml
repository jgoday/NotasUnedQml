import QtQuick 2.2
import QtQuick.Layouts 1.1


Text {
    Layout.alignment: Qt.AlignCenter
    text: "Notas Uned"

    color: "white"
    font.family: "Lobster"
    font.pointSize: 25

    FontLoader {
        source: "../resources/Lobster.ttf"
    }
}
