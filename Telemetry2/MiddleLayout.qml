import QtQuick
import QtQuick.Layouts

///////////// Middle Panel Layout QML /////////////
Rectangle {
    anchors.fill: parent
    color: "#181818"
    radius: 5

    // Signals to propagate to main
    signal mapLapButtonClicked()
    signal mapPauseButtonClicked()
    signal mapResetButtonClicked()

    // Properties
    property alias avgSecsPerLap: mapPanel1.avgSecsPerLap
    property alias runningTimeAttempt: mapPanel1.runningTimeAttempt
    property alias predictedTimePerLap: mapPanel1.predictedSecsPerLap

    // Map panel
    property alias lapTimesSecs: mapPanel1.lapTimesSecs
    property alias lapsCompleted: mapPanel1.lapsCompleted
    property alias lapCurrent: mapPanel1.lapCurrent

    GridLayout{
        anchors.fill: parent
        anchors.margins: 5
        columns: 3
        rows: 1
        columnSpacing: 2
        rowSpacing: 10

        ///////////// Middle Panel 1 /////////////
        Rectangle{
            property int midPanel1Width: 840

            Layout.fillHeight: true
            Layout.preferredWidth: midPanel1Width
            radius: 5
            color: "#181818"
            // border.color: "#d0d0d0"
            // border.width: 1

            ////// Mid panel for the gauges and plots //////
            MidPanel1{
            }
        }

        ///////////// Middle Panel 2 - MAP /////////////
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            radius: 10
            color: "#363640"

            /////// Map panel component ///////
            MapPanel{
                id: mapPanel1
                // Behavior for signals (propagate to main)
                onPauseButtonClicked: {
                    mapPauseButtonClicked()
                }
                onLapButtonClicked: {
                    mapLapButtonClicked()
                }
                onResetButtonClicked: {
                    mapResetButtonClicked()
                }
            }
        }
    }
}
