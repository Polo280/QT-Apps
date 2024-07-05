/* ELYOS TELEMETRY APPLICATION V2 */

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtCharts
// OTHER QT MODULES
import QtQuick 2.12
import QtLocation 5.15
import QtPositioning 5.15
// Custom QMLs
import "."  // Include same folder (imports are managed with folders)

Window {
    /////// BASIC WINDOW PROPERTIES ///////
    width: 1500
    height: 780
    visible: true
    opacity: 0.98
    color: "#272727"
    title: qsTr("ELYOS Telemetry")

    ///////////// GRID LAYOUT /////////////
    GridLayout{
        // Specify adjustment in parent item (window)
        anchors.fill: parent
        anchors.margins: 3
        // Specify layer
        z: 0
        // Rows and columns
        columns: 10
        rows: 10
        // Specify gaps between the rows and columns
        property int xSpacing: 4  // column spacing
        property int ySpacing: 0  // row spacing

        columnSpacing: xSpacing
        rowSpacing: ySpacing

        ///////////// Top Panel /////////////
        Item{
            id: topPanel
            property int columnSpanTop: 10
            property int rowSpanTop: 1

            Layout.columnSpan: columnSpanTop
            Layout.rowSpan: rowSpanTop

            Layout.preferredWidth: ((parent.width / parent.columns) * columnSpanTop) - parent.columnSpacing
            Layout.preferredHeight: ((parent.height / parent.rows) * rowSpanTop) - parent.rowSpacing

            Rectangle{
                anchors.fill: parent
                radius: 7
                color: "#181818"

                // This can be removed from children:
                TopPanel{
                    // TOP PANEL ITEM //
                    id: topPanelItem
                    onMenuButtonClicked: sideMenuBar.state = (sideMenuBar.state === "disabled")? "enabled" : "disabled"
                }
            }
        }
        ///////////// Mid panel  /////////////
        Item{
            id: midPanel
            property int columnSpanMid: 10
            property int rowSpanMid: 8

            Layout.columnSpan: columnSpanMid
            Layout.rowSpan: rowSpanMid

            Layout.preferredWidth: ((parent.width / parent.columns) * columnSpanMid) - parent.columnSpacing
            Layout.preferredHeight: ((parent.height / parent.rows) * rowSpanMid) - parent.rowSpacing

            ///// Inner layout rectangle /////
            Rectangle{
                anchors.fill: parent
                radius: 7
                color: "#181818"

                MiddleLayout{
                    ///// Middle layout item /////
                }
            }
        }

        ///////////// Bottom panel  /////////////
        Item{
            id: bottomPanel
            property int columnSpanBottom: 10
            property int rowSpanBottom: 1

            Layout.columnSpan: columnSpanBottom
            Layout.rowSpan: rowSpanBottom

            Layout.preferredWidth: ((parent.width / parent.columns) * columnSpanBottom) - parent.columnSpacing
            Layout.preferredHeight: ((parent.height / parent.rows) * rowSpanBottom) - parent.rowSpacing

            ///// Inner layout  /////
            Rectangle{
                anchors.fill: parent
                radius: 7
                color: "#181818"

                GridLayout{
                    anchors.fill: parent
                    anchors.margins: 5
                    columns: 3
                    rows: 1
                    columnSpacing: 10
                    rowSpacing: 10

                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        radius: 10
                        color: "white"
                    }

                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        radius: 10
                        color: "white"
                    }

                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        radius: 10
                        color: "white"
                    }
                }
            }
        }
    }

    ///////////// SIDE MENU ITEM /////////////
    SideMenu{
        id: sideMenuBar
    }

    ///////////// Timer1 /////////////
    Timer {
        id: timer1
        interval: 1000  // 1000 milliseconds = 1 second
        repeat: true    // Keep repeating the timer
        running: true

        onTriggered: {
            // Update the text display with the current time
            var date = new Date();
            topPanelItem.hourText = Qt.formatTime(date, "hh:mm:ss")
        }
    }
}
