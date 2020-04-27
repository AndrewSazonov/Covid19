pragma Singleton

import QtQuick 2.14

import Data 1.0

QtObject {

    // Initial application parameters
    property int appWindowFlags: Qt.Window // Qt.FramelessWindowHint | Qt.Dialog

    // Animation time
    property int themeChangeTime: 1000
    property int translationChangeTime: 300
    property int introAnimationDuration: 2000
    property int chartAnimationDuration: 1000

    // Loggin levels
    enum LoggingLevels {
        DisabledLevel = 0,
        InfoLevel = 1,
        DebugLevel = 2
    }
    property int loggingLevel: Variables.LoggingLevels.DebugLevel

    // TODO: get the following from the default DataHandler values.

    // Default
    property int countryIndex: DataHandler.USCountry
    property int casesIndex: DataHandler.TotalCases
    property int timePeriodIndex: DataHandler.OneMonthTimePeriod
    property int scaleIndex: DataHandler.LinearScale

    property bool confirmedRadioButtonState: true
    property bool recoveredRadioButtonState: false
    property bool deathsRadioButtonState: false

    property bool recoveredCheckBoxState: true
    property bool deathsCheckBoxState: true
    property bool activeCheckBoxState: true
}
