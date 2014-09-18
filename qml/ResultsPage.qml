import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQml 2.2

import QtWebKit 3.0
import QtWebKit.experimental 1.0

import "Core.js" as Core
import "Credentials.js" as Credentials
import "FontAwesome.js" as FontAwesome
import "Const.js" as Const

Item {
    id: container
    visible: true
    anchors.fill: parent

    signal errorReceived(string msg)
    signal backPressed()

    property int timerCount: 0

    Timer {
        id: timer
        interval: 60000
        running: false
        repeat: true
        onTriggered: {
            timerCount ++
            if (timerCount >= 5) {
                updatedAt.text = ""
                timerCount = 0
                init()
            }
            else {
                updatedAt.text = "Actualizado hace " + timerCount + " minutos "
            }
        }
    }

    GridLayout {
        id: gridLayout
        rows: 3
        columns: 1

        flow: GridLayout.TopToBottom
        anchors.fill: parent

        WebView {
            id: result
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
            visible: false
        }

        ProgressBar {
            id: progress
            indeterminate: true

            anchors.centerIn: parent
        }

        RowLayout {
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            // Background color
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                width: parent.width
                height: parent.height

                color: Const.Colors.Gray
            }
            FontAwesomeButton {
                id: backButton
                text: FontAwesome.Icons.Back
                Layout.alignment: Qt.AlignLeft
                onClicked: {
                    backPressed()
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: Credentials.credentialsAndMonth()
            }

            Text {
                id: updatedAt
                color: "#666"
            }

            FontAwesomeButton {
                id: updateButton
                text: FontAwesome.Icons.Update

                onClicked: {
                    init()
                }
            }

        }
    }

    WebView {
        id: mainWebView
        url: "https://serviweb.uned.es/sec-virtual/calificaciones/grados.asp"
        visible: false

        experimental.preferences.javascriptEnabled: true
        experimental.preferences.navigatorQtObjectEnabled: true
        experimental.onMessageReceived: {
            var data = JSON.parse(message.data)
            if (!data.error) {
                loadData(data.html)
            }
            else {
                errorReceived(data.error)
            }
        }
        onLoadingChanged: {
            init()
        }
    }

    function init() {
        timer.stop()

        updateButton.enabled = false
        backButton.enabled = false
        progress.visible = true
        result.visible = false
        Core.DoWork(mainWebView,
                    Credentials.selectedMonth,
                    Credentials.credentials.username,
                    Credentials.credentials.password)
    }

    function loadData(value) {
        updateButton.enabled = true
        backButton.enabled = true
        result.visible = true
        progress.visible = false
        result.loadHtml("<html><head>" +
                        "<style type='text/css'>" +
                        "body { background-color: #94cd81; font-size: 15pt} " +
                        "table { border: 0 ; width: 100%; background-color: #cae8c0;} " +
                        "</style>" +
                        "</head>" +
                        "<body>" + value + "</body></html>", "/")

        timer.start()
    }
}
