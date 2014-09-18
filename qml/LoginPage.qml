import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import "LoginController.js" as Controller
import "Const.js" as Const

ColumnLayout {
    id: loginPage
    spacing: 0
    anchors.centerIn: parent

    signal credentialsEntered(string user, string pass, bool rememberUser)
    property alias errorMessage: error.text
    property alias username: username.text
    property alias password: password.text
    property alias rememberUser: rememberUser.checked


    // Background color
    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: parent.height

        color: Const.Colors.Green
    }

    GridLayout {
        id: gridLayout
        rows: 6
        columns: 2

        flow: GridLayout.TopToBottom
        anchors.centerIn: parent

        Title {
            Layout.columnSpan: 2
        }

        Text {
            text: "Usuario"
        }
        Text {
            text: "Clave"
        }
        Text {
            text: "Guardar usuario y clave"
        }
        Text {
            id: error
            Layout.alignment: Qt.AlignCenter
            Layout.columnSpan: 2
            color: "red"
        }
        Button {
            Layout.alignment: Qt.AlignCenter
            Layout.columnSpan: 2
            text: "Login"
            onClicked: Controller.doLogin()
        }

        TextField {
            id: username
        }
        TextField {
            id: password
            echoMode: TextInput.Password
        }
        CheckBox {
            id: rememberUser
        }
    }
}
