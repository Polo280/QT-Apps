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
// JS Files

Window {
    /////// BASIC WINDOW PROPERTIES ///////
    width: 1500
    height: 780
    visible: true
    opacity: 0.98
    color: "#272727"
    title: qsTr("ELYOS Telemetry")

    ////// Define App Variables //////
    // Time control
    property int timeRunningAttempt: 0
    property int timeRunning: 0
    property bool timePaused: true
    property bool finishedRace: false
    // Race settings
    property int maxNumberLaps: 5
    property int attemptAvailableSecs: 620
    // Current Status
    property int remainingTime: attemptAvailableSecs
    property int lapTimeAux: 0
    property int currentLaps: 0

    ////// Define Signals //////
    signal resetAttemptTrigger()

    ///////////// GRID LAYOUT /////////////
    GridLayout{
        // Specify adjustment in parent item (window)
        anchors.fill: parent
        anchors.margins: 3
        // Specify layer
        z: 0
        // Rows and columns
        columns: 10
        rows: 40
        // Specify gaps between the rows and columns
        property int xSpacing: 4  // column spacing
        property int ySpacing: 0  // row spacing

        columnSpacing: xSpacing
        rowSpacing: ySpacing

        ///////////// Top Panel /////////////
        Item{
            id: topPanel
            property int columnSpanTop: 10
            property int rowSpanTop: 4

            Layout.columnSpan: columnSpanTop
            Layout.rowSpan: rowSpanTop

            Layout.preferredWidth: ((parent.width / parent.columns) * columnSpanTop) - parent.columnSpacing
            Layout.preferredHeight: ((parent.height / parent.rows) * rowSpanTop) - parent.rowSpacing

            Rectangle{
                anchors.fill: parent
                radius: 7
                color: "#181818"

                ////// TOP PANEL ITEM //////
                TopPanel{
                    id: topPanelItem
                    // Properties to display attempt status
                    attemptCurrentLaps: currentLaps
                    attemptRemainingSecs: remainingTime
                    // Manage side menu bar visibility
                    onMenuButtonClicked: sideMenuBar.state = (sideMenuBar.state === "disabled")? "enabled" : "disabled"

                }
            }
        }
        ///////////// Mid panel  /////////////
        Item{
            id: midPanel
            property int columnSpanMid: 10
            property int rowSpanMid: 34

            Layout.columnSpan: columnSpanMid
            Layout.rowSpan: rowSpanMid

            Layout.preferredWidth: ((parent.width / parent.columns) * columnSpanMid) - parent.columnSpacing
            Layout.preferredHeight: ((parent.height / parent.rows) * rowSpanMid) - parent.rowSpacing

            ///// Inner layout rectangle /////
            Rectangle{
                anchors.fill: parent
                radius: 7
                color: "#181818"

                ///// Middle layout item /////
                MiddleLayout{
                    id: midLayout
                    // Update properties
                    lapCurrent: currentLaps; // Get the current lap
                    runningTimeAttempt: timeRunningAttempt;  // Attempt run time
                    predictedTimePerLap: (timeRunningAttempt === 0)? 0 : Math.ceil(remainingTime / (maxNumberLaps - currentLaps))

                    // Signals from map panel //
                    // Pause behavior
                    onMapPauseButtonClicked: {
                        timePaused = !timePaused;
                        if(finishedRace){
                            finishedRace = false;
                        }
                    }
                    // New lap behavior
                    onMapLapButtonClicked: {
                        // Has only effect when timer is not paused
                        if(!timePaused && !finishedRace){
                            // Evaluate current lap to decide if finish race
                            if(currentLaps > 3){
                                finishedRace = true;
                            }

                            avgSecsPerLap = (timeRunningAttempt === 0)? 0 : Math.ceil(timeRunningAttempt / (currentLaps + 1));
                            //// Map panel (bottom) ////
                            // Update the boolean array of which laps are completed
                            var newLapsCompleted = lapsCompleted.slice(); // Create a copy of the array
                            newLapsCompleted[lapCurrent] = true;
                            lapsCompleted = newLapsCompleted; // Reassign to trigger update

                            // Update current lap time to complete
                            var newLapTimesSecs = lapTimesSecs.slice(); // Create a copy of the array
                            newLapTimesSecs[lapCurrent] = timeRunningAttempt - lapTimeAux;
                            lapTimesSecs = newLapTimesSecs; // Reassign to trigger update
                            lapTimeAux = timeRunningAttempt;  // Update aux to store the time of each individual lap

                            // Update current laps
                            currentLaps = (currentLaps < maxNumberLaps)? currentLaps + 1 : maxNumberLaps;
                        }
                    }
                    // Reset behavior
                    onMapResetButtonClicked: {
                        resetAttemptTrigger()   // Handler to reset in this file
                    }
                }
            }
        }

        ///////////// Bottom panel  /////////////
        Item{
            id: bottomPanel
            property int columnSpanBottom: 10
            property int rowSpanBottom: 2

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
                        color: "#181818"
                    }

                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        radius: 10
                        color: "#181818"
                    }

                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        radius: 10
                        color: "#181818"
                    }
                }
            }
        }
    }

    ///////////// SIDE MENU ITEM /////////////
    SideMenu{
        id: sideMenuBar
        // Handle exit button clicked
        onExitButtonClicked: Qt.quit()
        // Disable Default layout
        onSomethingClicked: midLayout.visible = false
        // Handle according to signal
        onMainPageButtonClicked: midLayout.visible = true
    }

    ///////////// Timer1 (1000 ms)  /////////////
    Timer {
        id: timer1
        interval: 1000  // 1000 milliseconds = 1 second
        repeat: true    // Keep repeating the timer
        running: true

        onTriggered: {
            // Update the text display with the current time
            var date = new Date();
            topPanelItem.hourText = Qt.formatTime(date, "hh:mm:ss");
            // App total run time update
            timeRunning += 1;
            // Remaining time update (if not paused)
            if(!timePaused && !finishedRace){
                timeRunningAttempt += 1;
                remainingTime = (remainingTime === 0)? 0 : remainingTime - 1;
            }
        }
    }

    /////// RESET ATTEMPT HANDLER ///////
    onResetAttemptTrigger: {
        finishedRace = false;
        currentLaps = 0;
        timeRunningAttempt = 0;
        remainingTime = attemptAvailableSecs;
        midLayout.avgSecsPerLap = 0;
        // Map panel bottom
        midLayout.lapsCompleted = [false, false, false, false, false]
        midLayout.lapTimesSecs = [0, 0, 0, 0, 0]
        lapTimeAux = 0; // Auxiliar in this file
    }
}
