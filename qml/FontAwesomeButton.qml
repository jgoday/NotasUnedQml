import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

Button {
    Layout.alignment: Qt.AlignCenter

    anchors.margins: 20

    style: ButtonStyle {
        label: Text {
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "FontAwesome"
            font.pointSize: 10
            text: control.text
        }
    }

    FontLoader {
        source: "../resources/fontawesome-webfont.ttf"
    }
}
