/* ELYOS TELEMETRY APPLICATION V2 */

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtCharts
// OTHER QT MODULES

// CUSTOM FILES
import SerialHandler
import "./QmlFiles"

Window {
    /////// BASIC WINDOW PROPERTIES ///////
    width: 1280
    height: 720
    visible: true
    opacity: 0.98
    color: "#272727"
    title: qsTr("ELYOS Telemetry")

    ///////////// GRID LAYOUT /////////////
    GridLayout{
        columns: 3
        // Specify gaps between the rows and columns
        columnSpacing: 10
        rowSpacing: 10
        // Specify adjustment in parent item (window)
        anchors.fill: parent
        anchors.margins: 10

        Rectangle{
            Layout.alignment: Qt.AlignLeft
            // Prefered width & height
            Layout.preferredHeight: 300
            Layout.preferredWidth: 100
            radius: 10
            color: "#303333"
        }

        Rectangle{
            Layout.alignment: Qt.AlignLeft
            // Prefered width & height
            Layout.preferredHeight: 300
            Layout.preferredWidth: 100
            radius: 5
            color: "blue"
        }

        Rectangle{
            Layout.alignment: Qt.AlignLeft
            // Prefered width & height
            Layout.preferredHeight: 300
            Layout.preferredWidth: 100
            color: "red"
        }
    }
}
