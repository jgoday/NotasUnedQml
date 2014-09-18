import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import "Credentials.js" as Credentials
import "Const.js" as Const

ApplicationWindow {
    id: page
    visible: true
    width: 640
    height: 480
    title: qsTr("Notas grado uned")

    ColumnLayout {
        anchors.fill: parent

        // Background color
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width
            height: parent.height

            color: Const.Colors.Green
        }

        Loader {
            id: main

            anchors.fill: parent
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            states: [
                 State {
                     name: "S1"
                     PropertyChanges { target: main; source: "LoginPage.qml"}
                 },
                 State {
                    name: "S2"
                    PropertyChanges { target: main; source: "MonthPage.qml"}
                 },
                 State {
                    name: "S3"
                    PropertyChanges { target: main; source: "ResultsPage.qml"}
                 }
             ]

            onLoaded : {
                if (main.state == "S1" && main.status === Loader.Ready) {
                    main.children[0].credentialsEntered.connect(onCredentialsEntered)

                    if (settings.value("rememberUser", false)) {
                        main.children[0].rememberUser = true
                        main.children[0].username = settings.value("username")
                        main.children[0].password = settings.secretValue("password")
                    }
                }
                else if (main.state == "S2" && main.status === Loader.Ready) {
                    main.children[0].backPressed.connect(onBackPressed)
                    main.children[0].monthPressed.connect(onMonthPressed)
                }
                else if (main.state == "S3" && main.status === Loader.Ready) {
                    main.children[0].backPressed.connect(onBackPressed)
                    main.children[0].errorReceived.connect(onErrorReceived)
                }
            }

            function onCredentialsEntered(user, pass, rememberUser) {
                Credentials.credentials.username = user
                Credentials.credentials.password = pass

                settings.setValue("rememberUser", rememberUser)
                if (rememberUser) {
                    settings.setValue("username", user)
                    settings.setSecretValue("password", pass)
                }
                main.state = "S2"
            }

            function onErrorReceived(msg) {
                main.state = "S1"
                main.children[0].errorMessage = msg
            }

            function onBackPressed() {
                if (main.state == "S2")
                    main.state = "S1"
                else
                    main.state = "S2"
            }

            function onMonthPressed() {
                main.state = "S3"
            }
        }

        Component.onCompleted: {
            main.state = "S1"
        }
    }
}
