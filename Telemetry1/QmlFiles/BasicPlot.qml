import QtQuick 2.15
import QtCharts

Item{
    // Plot related properties
    property string plotTitle: "plotDefault"
    property int plotHeight: 300
    property int plotWidth: 550
    property int maxPointCount: 50

    // Axes related properties
    property double minValueX: 0.0
    property double maxValueX: 0.0
    property double minValueY: 0.0
    property double maxValueY: 0.0

    // Variables
    property var plotPoints: []

    anchors.fill: parent

    ChartView{
        id: plot
        antialiasing: true
        visible: true
        width: plotWidth
        height: plotHeight
        title: plotTitle

        // Axes
        ValuesAxis{
            id: xAxis
            min: minValueX
            max: maxValueX
        }

        ValuesAxis{
            id: yAxis
            min: minValueY
            max: maxValueY
        }

        LineSeries{
            id: lineSeries
            axisX: xAxis
            axisY: yAxis
        }
    }

    // Append a 2 coordinate point in storage array and lineserie
    function addDataPoint(x, y){
        plotPoints.push({x: x, y: y});
        lineSeries.append(x, y);

        removeFirstDataPoint();
        checkMaxMin(x, y);
        console.log("Min x:", minValueX)
        console.log("Max x:", maxValueX)
        console.log("Min y:", minValueY)
        console.log("Max y:", maxValueY)
    }

    // Remove oldest points until number of points is below maximum allowed
    function removeFirstDataPoint(){
        while(lineSeries.count > maxPointCount){
            plotPoints.shift();
            lineSeries.remove(0);
        }
    }

    function checkMaxMin(x, y){
        if(lineSeries.count > 0){
            maxValueX = (maxValueX < x)? x : maxValueX;
            maxValueY = (maxValueY < y)? y : maxValueY;
            minValueX = plotPoints[0].x;
            minValueY = (minValueY > y)? y : minValueY;
        }else{
            minValueX = x
            minValueY = y
        }
    }

    function clear(){
        while(lineSeries.count > 0){
            plotPoints.shift();
            lineSeries.remove(0);
        }
    }
}
