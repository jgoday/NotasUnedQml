import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

import "Core.js" as Core
import "Credentials.js" as Credentials
import "FontAwesome.js" as FontAwesome
import "Const.js" as Const

ColumnLayout {
    anchors.fill: parent
    Layout.fillWidth: true

    signal backPressed()
    signal monthPressed()

    property string username
    property string password


    Title {
    }

    Button {
        text: "Enero"
        Layout.alignment: Qt.AlignCenter

        onClicked: {
            Credentials.selectedMonth = Core.Const.ConvocatoriaFebrero
            monthPressed()
        }
    }

    Button {
        text: "Junio"
        Layout.alignment: Qt.AlignCenter

        onClicked: {
            Credentials.selectedMonth = Core.Const.ConvocatoriaJunio
            monthPressed()
        }
    }

    Button {
        text: "Septiembre"
        Layout.alignment: Qt.AlignCenter

        onClicked: {
            Credentials.selectedMonth = Core.Const.ConvocatoriaSeptiembre
            monthPressed()
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignBottom
        Layout.fillWidth: true
        spacing: 10

        // Background color
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width
            height: parent.height

            color: Const.Colors.Gray
        }

        FontAwesomeButton {
            text: FontAwesome.Icons.Back
            Layout.alignment: Qt.AlignLeft
            onClicked: {
                backPressed()
            }
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: Credentials.credentialsAndMonth()
        }

        Text {
            Layout.alignment: Qt.AlignRight
        }
    }
}
