import QtQuick 2.14

QtObject {

    property string country: "Denmark"
    property string cases: "Total"
    property string timePeriod: "1 month"
    property string scale: "Linear"

    property bool showRecovered: true
    property bool showActive: true
    property bool showDeaths: true

    property bool loadingState: false
    property bool downloadingState: false

    property int yMin: 0
    property int yMax: 2260
    property string xMin: "10 Mar"
    property string xMax: "17 Mar"

    property var xLabels: ["10 Mar", "", "12 Mar", "", "14 Mar", "", "16 Mar", ""]
    property var dateList: ["10 Mar", "11 Mar", "12 Mar", "13 Mar", "14 Mar", "15 Mar", "16 Mar", "17 Mar"]
    property var deathsArray: [0, 1, 10, 20, 30, 45, 50, 60]
    property var activeArray: [200, 500, 1000, 1200, 1500, 1600, 1650, 1700]
    property var recoveredArray: [20, 50, 70, 200, 300, 350, 400, 500]

    function downloadDataFromWebStarted() {
        downloadingState = true
        downloadingState = false
    }

}
