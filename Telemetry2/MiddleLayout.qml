import QtQuick
import QtQuick.Layouts

///////////// Middle Panel Layout QML /////////////
Rectangle {
    anchors.fill: parent

    // Properties of main rectangle for panel
    // border.color: "#d0d0d0"
    // border.width: 1
    color: "#181818"
    radius: 5

    GridLayout{
        anchors.fill: parent
        anchors.margins: 5
        columns: 3
        rows: 1
        columnSpacing: 10
        rowSpacing: 10

        ///////////// Middle Panel 1 /////////////
        Rectangle{
            property int midPanel1Width: 800

            Layout.fillHeight: true
            Layout.preferredWidth: midPanel1Width
            radius: 5
            color: "#181818"
            // border.color: "#d0d0d0"
            // border.width: 1

            MidPanel1{
            }
        }

        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            radius: 10
            color: "#363640"
            // border.color: "#d0d0d0"
            // border.width: 1
        }
    }
}
