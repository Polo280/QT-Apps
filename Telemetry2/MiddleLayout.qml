import QtQuick
import QtQuick.Layouts

///////////// Middle Panel Layout QML /////////////
Item {
    anchors.fill: parent

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
