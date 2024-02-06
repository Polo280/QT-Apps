import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtCharts
import SerialHandler

Window {
    // Basic properties
    width: 1280
    height: 720
    visible: true
    opacity: 0.95
    color: Material.backgroundColor
    title: qsTr("Test 1")

    RowLayout{
        anchors.fill: parent   // Fill the window (parent) With this row layout in all directions
        spacing: 0  // Spacing in px between items in layout
        id: windowLayout

        // LEFT MENU Background
        Rectangle{
            Layout.alignment: Qt.AlignLeft
            Layout.fillHeight: true
            Layout.preferredWidth: 250
            color: "#272727"
            border.color: "white"
            border.width: 1

            // MENU ITEMS
            ColumnLayout{
                anchors.fill: parent
                anchors.topMargin: 0
                spacing: 20
                // MENU title background
                Rectangle{
                    id: menuRect
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.fillWidth: true
                    Layout.preferredHeight: 75
                    color: "#285078"
                    border.color: "white"
                    border.width: 1

                    // MENU title
                    Text{
                        anchors.centerIn: parent
                        // Position text in top center
                        text: "MENU"
                        font.family: "Tahoma"
                        font.pointSize: 25
                        font.bold: true
                        color: "white"
                    }
                }

                // Baud rate title label
                Text{
                    id: baudRateText
                    anchors.top: menuRect.bottom
                    anchors.topMargin: 35
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    horizontalAlignment: Text.AlignHCenter    // For TEXTS use Text.AlignHCenter
                    text: "Baud Rate"
                    font.family: "Tahoma"
                    font.pointSize: 15
                    font.bold: false
                    color: "white"
                }

                // Baud rate selector combo box
                ComboBox{
                     id: baudRateBox
                     anchors.top: baudRateText.bottom
                     anchors.topMargin: 2
                     anchors.horizontalCenter: parent.horizontalCenter
                     Layout.preferredWidth: parent.width - 60
                     Layout.preferredHeight: 50
                     model: [ "1200", "2400", "4800", "9600", "19200", "38400", "57600", "115200" ]

                     background: Rectangle{   // Use rectangle to set background configuration
                         color: "#a4a8ab"
                         radius: 5
                     }
                }

                // Connect through serial button
                Button{
                    id: connectButton
                    anchors.top: baudRateBox.bottom
                    Layout.alignment: Qt.AlignHCenter
                    anchors.topMargin: 5
                    Layout.preferredWidth: parent.width - 60
                    Layout.preferredHeight: 50
                    text: "Connect"
                    background: Rectangle{
                        color: connectButton.pressed? "steelblue": "lightblue"
                        radius: 10

                        Behavior on color {
                                    ColorAnimation { duration: 200 }
                        }
                    }
                    // On click configure a new instance of serial handler and open serial port
                    onClicked: {
                        console.log(baudRateBox.currentText)
                        SerialHandler.configurePort(baudRateBox.currentText, "COM4")
                        SerialHandler.openPort(0);
                    }
                }
            }
        }

        // Right Background color
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "#313436"   // Dark gray color
            border.color: "white"
            border.width: 1

            // Layout for items in the right side of the window
            ColumnLayout{
                anchors.fill: parent

                // Upper bar rectangle
                Rectangle{
                    id: upperBarRect
                    Layout.preferredWidth: parent.width - 200
                    Layout.preferredHeight: 75
                    anchors.top: parent.top
                    color: "#272727"
                    border.color: "white"
                    border.width: 1

                    // Layout to arrange items horizontally in upper bar
                    RowLayout{
                        anchors.fill: parent

                        // MAIN TITLE
                        Text{
                            id: mainTitle
                            anchors.horizontalCenter: parent.horizontalCenter
                            // Position text in top center
                            text: "TELEMETRY"
                            font.family: "Tahoma"
                            font.pointSize: 30
                            font.bold: true
                            color: "white"
                        }
                    }
                }

                // Rectangle for time info
                Rectangle{
                    id: upperRightRect
                    anchors.right: parent.right
                    anchors.top: parent.top
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: upperBarRect.height
                    color: "#1d1e1f"
                    border.color: "white"
                    border.width: 1.5

                    // Weather image
                    Image{
                        id: weatherImg
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 5
                        source: "file:///C:/Users/jorgl/OneDrive/Escritorio/QT Apps/Telemetry1/Weather.png"
                        width: 65
                        height: 65
                        opacity: 0.6
                        fillMode: Image.PreserveAspectCrop
                    }

                    // Date text
                    Text{
                        id: dateText
                        anchors.left: weatherImg.right
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        anchors.topMargin: 12
                        text: Date().toString().slice(0, 10)  // Javacript
                        font.family: "Tahoma"
                        font.pointSize: 12
                        font.bold: false
                        color: "white"
                    }

                    // Time text
                    Text{
                        id: timeText
                        anchors.left: weatherImg.right
                        anchors.leftMargin: 12
                        anchors.top: dateText.bottom
                        anchors.topMargin: 3
                        text: ""
                        font.family: "Tahoma"
                        font.pointSize: 15
                        font.bold: false
                        color: "white"
                    }
                }

                ChartView{
                    id:plot1
                    title: "Voltage over Time"
                    anchors.top: upperBarRect.bottom
                    anchors.topMargin: 15
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    Layout.preferredHeight: 300
                    Layout.preferredWidth: 550
                    antialiasing: true

                    LineSeries{
                        name: "Voltage (V)"
                        XYPoint {x:0; y:0}
                        XYPoint {x:1; y:1}
                    }
                }

            }
        }
    }

    Connections{
        target: SerialHandler
        onErrorOccurred: {
            console.log("Error: ", errorMessage)
        }

        onNewDataReceived: {
            console.log("New data received: ", data)
        }
    }

    // Insert things to do after parent (main window) is created
    Component.onCompleted: {

    }

    // Timer to keep app updated
    Timer{
        interval: 1000
        running: true
        repeat: true

        // Things to keep updated
        onTriggered: {
            timeText.text = Date().toString().split(" ")[3]   // Javascript
        }
    }
}
