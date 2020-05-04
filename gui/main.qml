import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.14
import QtQuick.XmlListModel 2.14
import Qt.labs.settings 1.1
import QtCharts 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0
import Templates.Charts 1.0
import Application 1.0 as Appplication
import Data 1.0

ApplicationWindow {
    id: appWindow

    minimumWidth:  middleSelectorsContainer.spacing * 2 +
                   leftButtonsContainer.width +
                   rightButtonsContainer.width +
                   countrySelector.width
    minimumHeight: minimumWidth


    ///property int savedCurrentIndex


    ////////////////////////////////////////////////////////////////////////

    DataHandler {
        id: dataHandler
    }

    ////////////////////////////////////////////////////////////////////////

    Dialog {
        id: aboutDialog

        //anchors.centerIn: parent
        x: (parent.width - width) * 0.5
        y: (parent.height - height) * 0.5

        title: qsTr("About")

        modal: true
        standardButtons: Dialog.Ok

        Column {
            spacing: Globals.Sizes.fontInPixels * 1.0


            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Globals.Sizes.fontInPixels * 0.5

                // Application logo
                Image {
                    width: Globals.Sizes.fontInPixels * 16
                    fillMode: Image.PreserveAspectFit
                    antialiasing: true
                    smooth: true
                    source: Globals.Colors.appLogoSrc

                    // Link to app website
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Qt.openUrlExternally("https://covidist.apptimity.com")
                    }
                }

                // Application version
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: Globals.Fonts.sans
                    font.pixelSize: Globals.Sizes.fontInPixels
                    color: Globals.Colors.appBarButtonForeground
                    text: qsTr("Version") + " 0.4.1 (4 May 2020)"
                }
            }


            // Application description
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: Globals.Fonts.sans
                font.pixelSize: Globals.Sizes.fontInPixels
                text: qsTr("Coronavirus disease (COVID-19) cases")
            }

            // Data source
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: Globals.Fonts.sans
                    font.pixelSize: Globals.Sizes.fontInPixels
                    text: qsTr("Time series data are taken from")
                }

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: Globals.Fonts.sans
                    font.pixelSize: Globals.Sizes.fontInPixels
                    color: Globals.Colors.themeAccent
                    text: qsTr("Johns Hopkins University CSSE")

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Qt.openUrlExternally("https://github.com/CSSEGISandData/COVID-19")
                    }
                }
            }

            // Footer
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: Globals.Fonts.sans
                font.pixelSize: Globals.Sizes.fontInPixels
                color: Globals.Colors.appBarButtonForeground
                text: "© 2020 • Apptimity"
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////

    Appplication.PreferencesDialog {
        id: preferencesDialog

        //anchors.centerIn: parent
        x: (parent.width - width) * 0.5
        y: (parent.height - height) * 0.5
    }

    ////////////////////////////////////////////////////////////////////////

    Dialog {
        id: moreControlsDialog

        x: (parent.width - width) * 0.5
        y: (parent.height - height) * 0.5

        title: qsTr("More controls")

        modal: true
        standardButtons: Dialog.Ok

        Column {
            //spacing: Globals.Sizes.fontInPixels * 0.25

            Row {
                visible: !casesSelector.visible
                spacing: Globals.Sizes.fontInPixels * 0.5

                Label {
                    enabled: false
                    width: Globals.Sizes.fontInPixels * 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Cases") + ":"
                }

                ComboBox {
                    width: Globals.Sizes.fontInPixels * 8

                    model: casesSelector.model
                    valueRole: casesSelector.valueRole
                    textRole: casesSelector.textRole

                    // Bind with the value stored in the backend.
                    currentIndex: dataHandler.cases

                    // When an item is changed (from everywhere), update the main selector
                    // current index, which will trigger an update of the backend.
                    onCurrentIndexChanged: casesSelector.currentIndex = currentIndex
                }
            }

            Row {
                visible: !timePeriodSelector.visible
                spacing: Globals.Sizes.fontInPixels * 0.5

                Label {
                    enabled: false
                    width: Globals.Sizes.fontInPixels * 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Time period") + ":"
                }

                ComboBox {
                    width: Globals.Sizes.fontInPixels * 8

                    model: timePeriodSelector.model
                    valueRole: timePeriodSelector.valueRole
                    textRole: timePeriodSelector.textRole

                    // Bind with the value stored in the backend.
                    currentIndex: dataHandler.timePeriod

                    // When an item is changed (from everywhere), update the main selector
                    // current index, which will trigger an update of the backend.
                    onCurrentIndexChanged: timePeriodSelector.currentIndex = currentIndex
                }
            }

            Row {
                visible: !scaleSelector.visible
                spacing: Globals.Sizes.fontInPixels * 0.5

                Label {
                    enabled: false
                    width: Globals.Sizes.fontInPixels * 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Scale") + ":"
                }

                ComboBox {
                    enabled: scaleSelector.enabled

                    width: Globals.Sizes.fontInPixels * 8

                    model: scaleSelector.model
                    valueRole: scaleSelector.valueRole
                    textRole: scaleSelector.textRole

                    // Bind with the value stored in the backend.
                    currentIndex: dataHandler.scale

                    // When an item is changed (from everywhere), update the main selector
                    // current index, which will trigger an update of the backend.
                    onCurrentIndexChanged: scaleSelector.currentIndex = currentIndex
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////

    Dialog {

        id: debugDialog

        x: (parent.width - width) * 0.5
        y: (parent.height - height) * 0.5

        width: parent.width - Globals.Sizes.fontInPixels
        height: parent.height - Globals.Sizes.fontInPixels

        title: qsTr("Debug")

        modal: true
        standardButtons: Dialog.Ok

        Flickable {
            anchors.fill: parent

            TextArea.flickable: TextArea {
                id: debugTextArea

                readOnly: true
                wrapMode: TextEdit.Wrap
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////


    ToolBar {
        id: toolbar

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        height: Globals.Sizes.appBarHeight

        Item {
            anchors.fill: parent

            ////////////////////////////////////////////////
            ////////////////////////////////////////////////
            ////////////////////////////////////////////////
            Row {
                id: leftButtonsContainer

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: (Globals.Sizes.appBarHeight - Globals.Sizes.toolButtonHeight) * 0.5

                ToolButton {
                    text: "\ue803"
                    ToolTip.text: "Show about window"
                    onClicked: aboutDialog.visible = true
                }

                ToolButton {
                    text: "\ue802"
                    ToolTip.text: "Show preferences"
                    onClicked: preferencesDialog.visible = true
                    onPressAndHold: debugDialog.visible = true
                }
            }

            ////////////////////////////////////////////////
            ////////////////////////////////////////////////
            ////////////////////////////////////////////////
            Row {
                id: middleSelectorsContainer

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: Globals.Sizes.fontInPixels * 1.5

                ////////////////////////////////////////////////
                Row {
                    id: countrySelectorContainer

                    anchors.verticalCenter: parent.verticalCenter
                    spacing: Globals.Sizes.fontInPixels * 0.5

                    Label {
                        id: countryLabel

                        visible: appWindow.width >=
                                 middleSelectorsContainer.spacing * 6 +
                                 leftButtonsContainer.width +
                                 rightButtonsContainer.width +
                                 countrySelector.width +
                                 casesSelector.width +
                                 timePeriodSelector.width +
                                 scaleSelector.width +
                                 countryLabel.width +
                                 casesLabel.width +
                                 timePeriodLabel.width +
                                 scaleLabel.width

                        enabled: false
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Country") + ":"
                    }

                    ComboBox {
                        id: countrySelector

                        width: Globals.Sizes.fontInPixels * 9.5

                        model: [
                            { value: DataHandler.AustriaCountry, text: qsTr("Austria") },
                            { value: DataHandler.BelarusCountry, text: qsTr("Belarus") },
                            { value: DataHandler.BelgiumCountry, text: qsTr("Belgium") },
                            { value: DataHandler.DenmarkCountry, text: qsTr("Denmark") },
                            { value: DataHandler.FinlandCountry, text: qsTr("Finland") },
                            { value: DataHandler.FranceCountry, text: qsTr("France") },
                            { value: DataHandler.GermanyCountry, text: qsTr("Germany") },
                            { value: DataHandler.IndiaCountry, text: qsTr("India") },
                            { value: DataHandler.ItalyCountry, text: qsTr("Italy") },
                            { value: DataHandler.JapanCountry, text: qsTr("Japan") },
                            { value: DataHandler.NetherlandsCountry, text: qsTr("Netherlands") },
                            { value: DataHandler.NorwayCountry, text: qsTr("Norway") },
                            { value: DataHandler.PolandCountry, text: qsTr("Poland") },
                            { value: DataHandler.PortugalCountry, text: qsTr("Portugal") },
                            { value: DataHandler.RussiaCountry, text: qsTr("Russia") },
                            { value: DataHandler.SpainCountry, text: qsTr("Spain") },
                            { value: DataHandler.SwedenCountry, text: qsTr("Sweden") },
                            { value: DataHandler.SwitzerlandCountry, text: qsTr("Switzerland") },
                            { value: DataHandler.UkraineCountry, text: qsTr("Ukraine") },
                            { value: DataHandler.UnitedKingdomCountry, text: qsTr("United Kingdom") },
                            { value: DataHandler.USCountry, text: qsTr("US") }
                        ]
                        valueRole: "value"
                        textRole: "text"

                        // Bind with the value stored in the backend.
                        currentIndex: dataHandler.country

                        // When an item is changed (from everywhere), update the backend
                        onCurrentIndexChanged: dataHandler.country = currentIndex
                    }
                }

                ////////////////////////////////////////////////
                Row {
                    id: casesSelectorContainer

                    anchors.verticalCenter: parent.verticalCenter
                    spacing: Globals.Sizes.fontInPixels * 0.5

                    Label {
                        id: casesLabel

                        visible: appWindow.width >=
                                 middleSelectorsContainer.spacing * 6 +
                                 leftButtonsContainer.width +
                                 rightButtonsContainer.width +
                                 countrySelector.width +
                                 casesSelector.width +
                                 timePeriodSelector.width +
                                 scaleSelector.width +
                                 countryLabel.width +
                                 casesLabel.width +
                                 timePeriodLabel.width +
                                 scaleLabel.width

                        enabled: false
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Cases") + ":"
                    }

                    ComboBox {
                        id: casesSelector

                        visible: appWindow.width >=
                                 middleSelectorsContainer.spacing * 3 +
                                 leftButtonsContainer.width +
                                 rightButtonsContainer.width +
                                 countrySelector.width +
                                 width

                        width: countrySelector.width

                        model: [
                            { value: DataHandler.TotalCases,   text: qsTr("Total") },
                            { value: DataHandler.DailyNewCases, text: qsTr("Daily New") }
                        ]
                        valueRole: "value"
                        textRole: "text"

                        // Bind with the value stored in the backend.
                        currentIndex: dataHandler.cases

                        // When an item is changed (from everywhere), update the gui selectors and backend
                        onCurrentIndexChanged: {
                            if (currentIndex === DataHandler.TotalCases) {
                                recoveredCheckBox.checked = true
                                activeCheckBox.checked = true
                                deathsCheckBox.checked = true
                            } else if (currentIndex === DataHandler.DailyNewCases) {
                                confirmedRadioButton.checked = true
                            }
                            dataHandler.cases = currentIndex
                        }
                    }
                }

                ////////////////////////////////////////////////
                Row {
                    id: timePeriodSelectorContainer

                    anchors.verticalCenter: parent.verticalCenter
                    spacing: Globals.Sizes.fontInPixels * 0.5

                    Label {
                        id: timePeriodLabel

                        visible: appWindow.width >=
                                 middleSelectorsContainer.spacing * 6 +
                                 leftButtonsContainer.width +
                                 rightButtonsContainer.width +
                                 countrySelector.width +
                                 casesSelector.width +
                                 timePeriodSelector.width +
                                 scaleSelector.width +
                                 countryLabel.width +
                                 casesLabel.width +
                                 timePeriodLabel.width +
                                 scaleLabel.width

                        enabled: false
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Time period") + ":"
                    }

                    ComboBox {
                        id: timePeriodSelector

                        width: countrySelector.width

                        visible: appWindow.width >=
                                 middleSelectorsContainer.spacing * 4 +
                                 leftButtonsContainer.width +
                                 rightButtonsContainer.width +
                                 countrySelector.width +
                                 casesSelector.width +
                                 width

                        model: [
                            { value: DataHandler.TwoWeeksTimePeriod,   text: qsTr("2 weeks") },
                            { value: DataHandler.ThreeWeeksTimePeriod, text: qsTr("3 weeks") },
                            { value: DataHandler.OneMonthTimePeriod,   text: qsTr("1 month") },
                            { value: DataHandler.TwoMonthsTimePeriod,  text: qsTr("2 months") }
                        ]
                        valueRole: "value"
                        textRole: "text"

                        // Bind with the value stored in the backend.
                        currentIndex: dataHandler.timePeriod

                        // When an item is changed (from everywhere), update the backend
                        onCurrentIndexChanged: dataHandler.timePeriod = currentIndex
                    }
                }

                ////////////////////////////////////////////////
                Row {
                    id: scaleSelectorContainer

                    anchors.verticalCenter: parent.verticalCenter
                    spacing: Globals.Sizes.fontInPixels * 0.5

                    Label {
                        id: scaleLabel

                        visible: appWindow.width >=
                                 middleSelectorsContainer.spacing * 6 +
                                 leftButtonsContainer.width +
                                 rightButtonsContainer.width +
                                 countrySelector.width +
                                 casesSelector.width +
                                 timePeriodSelector.width +
                                 scaleSelector.width +
                                 countryLabel.width +
                                 casesLabel.width +
                                 timePeriodLabel.width +
                                 scaleLabel.width

                        enabled: false
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Scale") + ":"
                    }

                    ComboBox {
                        id: scaleSelector

                        visible: appWindow.width >=
                                 middleSelectorsContainer.spacing * 5 +
                                 leftButtonsContainer.width +
                                 rightButtonsContainer.width +
                                 countrySelector.width +
                                 casesSelector.width +
                                 timePeriodSelector.width +
                                 width

                        enabled: false
                        width: countrySelector.width

                        model: [
                            { value: DataHandler.LinearScale,   text: qsTr("Linear") },
                            { value: DataHandler.LogarithmicScale, text: qsTr("Logarithmic") }
                        ]
                        valueRole: "value"
                        textRole: "text"

                        // Bind with the value stored in the backend.
                        currentIndex: dataHandler.scale

                        // When an item is changed (from everywhere), update the backend
                        onCurrentIndexChanged: dataHandler.scale = currentIndex
                    }
                }
            }
        }

        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
        Row {
            id: rightButtonsContainer

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: (Globals.Sizes.appBarHeight - Globals.Sizes.toolButtonHeight) * 0.5

            ToolButton {
                text: "\ue804"
                ToolTip.text: "Download data"
                onClicked: dataHandler.downloadDataFromWebStarted()

                RotationAnimation on rotation {
                    running: dataHandler.downloadingState
                    loops: Animation.Infinite
                    alwaysRunToEnd: true
                    from: 0
                    to: 360
                    duration: 1000
                }
            }

            ToolButton {
                enabled: !casesSelector.visible ||
                         !timePeriodSelector.visible ||
                         !scaleSelector.visible
                text: "\uf141"
                ToolTip.text: qsTr("More controls")
                onClicked: moreControlsDialog.visible = true
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////

    ChartView {
        id: chartView

        antialiasing: true

        anchors.top: chartbar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        //legend.visible: false

        anchors.topMargin: -12
        anchors.bottomMargin: -12 + Globals.Sizes.fontInPixels * 1.0
        anchors.leftMargin: -12 + Globals.Sizes.fontInPixels * 3.75
        anchors.rightMargin: -12 + Globals.Sizes.fontInPixels * 2.5

        BarCategoryAxis {
            id: axisX

            labelsVisible: false

            categories: dataHandler.dateList
            min: dataHandler.xMin
            max: dataHandler.xMax

            // Binding is brocken when min and max are updated in onCategoriesChanged
            // This update is needed when app translation is changed, because for unclear
            // reason categories are updated and this update happens already after
            // dataHandler.xMin is updated. As a result, axisX.min is resetted to the
            // first element in the categories list...
            // Temporary solution: recreate binding on axisX.onCategoriesChanged
            onCategoriesChanged: {
                min = dataHandler.xMin
                max = dataHandler.xMax
            }
            Binding on min {
                when: axisX.onCategoriesChanged
                value: dataHandler.xMin
            }
            Binding on max {
                when: axisX.onCategoriesChanged
                value: dataHandler.xMax
            }
        }

        ValueAxis {
            id: axisY

            labelsVisible: false
            gridVisible: dataHandler.scale === DataHandler.LinearScale
            minorGridVisible: gridVisible

            labelsFont.pixelSize: 1 // minimize the space taken by labels (inspite they are invisible)

            titleVisible: false
            //labelFormat: "%d" or "%i" or "%.0f" CRASHES on iOS !!!

            tickCount: 4
            minorTickCount: 9

            min: 0
            max: dataHandler.yMax
        }

        StackedBarSeries {
            id: barSeries

            axisX: axisX
            axisY: axisY

            BarSet {
                id: barsetConfirmed
                label: qsTr("Confirmed")
                color: Globals.Colors.confirmed
                values: dataHandler.confirmedArray
            }

            BarSet {
                id: barsetDeaths
                label: qsTr("Deaths")
                color: Globals.Colors.deaths
                values: dataHandler.deathsArray
            }

            BarSet {
                id: barsetActive
                label: qsTr("Active")
                color: Globals.Colors.active
                values: dataHandler.activeArray
            }

            BarSet {
                id: barsetRecovered
                label: qsTr("Recovered")
                color: Globals.Colors.recovered
                values: dataHandler.recoveredArray
            }

            onHovered: {
                const date = axisX.categories[index]
                const confirmed = dataHandler.confirmedArray[index]
                const recovered = dataHandler.recoveredArray[index]
                const active = dataHandler.activeArray[index]
                const deaths = dataHandler.deathsArray[index]

                infoToolTipDate.text = translateDate(date)

                if (casesSelector.currentIndex === DataHandler.TotalCases)
                {
                    infoToolTipRecovered.text = recoveredCheckBox.checked ? qsTr("Recovered") + ": %1".arg(recovered) : ""
                    infoToolTipActive.text = activeCheckBox.checked ? qsTr("Active") + ": %1".arg(active) : ""
                    infoToolTipDeaths.text = deathsCheckBox.checked ? qsTr("Deaths") + ": %1".arg(deaths) : ""
                    infoToolTipConfirmed.text = recoveredCheckBox.checked && activeCheckBox.checked && deathsCheckBox.checked ? qsTr("Confirmed") + ": %1".arg(recovered + active + deaths) : ""
                }
                else if (casesSelector.currentIndex === DataHandler.DailyNewCases)
                {
                    infoToolTipRecovered.text = recoveredRadioButton.checked ? qsTr("Recovered") + ": %1".arg(recovered) : ""
                    infoToolTipDeaths.text = deathsRadioButton.checked ? qsTr("Deaths") + ": %1".arg(deaths) : ""
                    infoToolTipConfirmed.text = confirmedRadioButton.checked ? qsTr("Confirmed") + ": %1".arg(confirmed) : ""
                    infoToolTipActive.text = ""
                }

                infoToolTip.visible = status
            }
        }

        // Custom Y-axis labels (formatted)
        Column {
            id: yAxisLabels

            property real tickInterval: (axisY.max - axisY.min) / (axisY.tickCount - 1)
            property real extraY: axisY.max - tickInterval * (dataHandler.yLabels.length - 1)
            property real extraHeight: chartView.plotArea.height / axisY.max * extraY

            x: chartView.plotArea.x - childrenRect.width - Globals.Sizes.fontInPixels * 0.5
            y: chartView.plotArea.y + extraHeight - Globals.Sizes.fontInPixels * 0.75

            Repeater {
                id: repeaterY

                model: dataHandler.yLabels.length

                Rectangle {
                    height: (chartView.plotArea.height - yAxisLabels.extraHeight) / (repeaterY.count - 1)
                    width: Globals.Sizes.fontInPixels * 4
                    color: "transparent"

                    Label {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        verticalAlignment: Text.AlignTop
                        //color: "orange"
                        text: dataHandler.yLabels[index]
                    }
                }
            }

        }

        // Custom X-axis labels (without text elide...!)
        Row {
            x: chartView.plotArea.x
            y: chartView.plotArea.y + chartView.plotArea.height

            Repeater {
                id: repeaterX
                model: dataHandler.xLabels.length

                Rectangle {
                    width: chartView.plotArea.width / repeaterX.count
                    height: Globals.Sizes.fontInPixels * 2
                    color: "transparent"

                    Label {
                        anchors.centerIn: parent
                        //color: "white"
                        text: translateDate(dataHandler.xLabels[index])
                    }
                }
            }
        }



        ////////////////////////////////////////////////////////////////////////



        ToolTip {
            id: infoToolTip

            ///parent: Overlay.overlay

            x: (parent.width - width) * 0.5
            y: Globals.Sizes.fontInPixels + Globals.Sizes.fontInPixels * 0.25//3
            //timeout: 3000
            //closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

            contentItem: Column {
                Label {
                    id: infoToolTipDate
                    font.family: Globals.Fonts.sans
                    font.pixelSize: Globals.Sizes.fontInPixels
                }

                Label {
                    id: infoToolTipRecovered
                    visible: text !== ""
                    font.family: Globals.Fonts.sans
                    font.pixelSize: Globals.Sizes.fontInPixels
                    color: Globals.Colors.recoveredText
                }

                Label {
                    id: infoToolTipActive
                    visible: text !== ""
                    font.family: Globals.Fonts.sans
                    font.pixelSize: Globals.Sizes.fontInPixels
                    color: Globals.Colors.activeText
                }

                Label {
                    id: infoToolTipDeaths
                    visible: text !== ""
                    font.family: Globals.Fonts.sans
                    font.pixelSize: Globals.Sizes.fontInPixels
                    color: Globals.Colors.deathsText
                }

                Label {
                    id: infoToolTipConfirmed
                    visible: (text !== "") && (Number(recoveredCheckBox.checked) + Number(activeCheckBox.checked) + Number(deathsCheckBox.checked) >= 2)
                    font.family: Globals.Fonts.sans
                    font.pixelSize: Globals.Sizes.fontInPixels
                    color: Globals.Colors.confirmedText
                }
            }
        }

    }

    ////////////////////////////////////////////////////////////////////////

    Item {
        id: chartbar

        anchors.top: toolbar.bottom
        height: childrenRect.height
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: Globals.Sizes.fontInPixels * 0.5
        anchors.rightMargin: Globals.Sizes.fontInPixels * 0.5

        Row {
            visible: casesSelector.currentIndex === DataHandler.TotalCases
            anchors.horizontalCenter: parent.horizontalCenter

            CheckBox {
                id: recoveredCheckBox

                width: (implicitWidth + activeCheckBox.width + deathsCheckBox.width) > chartbar.width ?
                           chartbar.width - activeCheckBox.width - deathsCheckBox.width :
                           implicitWidth

                anchors.verticalCenter: parent.verticalCenter
                checked: true
                checkable: activeCheckBox.checked || deathsCheckBox.checked

                color: barsetRecovered.color

                text: qsTr("Recovered")

                onToggled: dataHandler.showRecovered = checked
            }

            CheckBox {
                id: activeCheckBox

                anchors.verticalCenter: parent.verticalCenter
                checked: true
                checkable: recoveredCheckBox.checked || deathsCheckBox.checked

                color: barsetActive.color

                text: qsTr("Active")

                onToggled: dataHandler.showActive = checked
            }

            CheckBox {
                id: deathsCheckBox

                anchors.verticalCenter: parent.verticalCenter
                checked: true
                checkable: activeCheckBox.checked || recoveredCheckBox.checked

                color: barsetDeaths.color

                text: qsTr("Deaths")

                onToggled: dataHandler.showDeaths = checked
            }
        }

        Row {
            visible: casesSelector.currentIndex === DataHandler.DailyNewCases
            anchors.horizontalCenter: parent.horizontalCenter

            RadioButton {
                id: confirmedRadioButton

                width: (implicitWidth + recoveredRadioButton.width + deathsRadioButton.width) > chartbar.width ?
                           chartbar.width - recoveredRadioButton.width - deathsRadioButton.width :
                           implicitWidth

                anchors.verticalCenter: parent.verticalCenter
                checked: Globals.Variables.confirmedRadioButtonState

                color: barsetConfirmed.color

                text: qsTr("Confirmed")

                onToggled: {
                    dataHandler.showRecovered = !checked
                    dataHandler.showDeaths = !checked
                    dataHandler.showConfirmed = checked
                }
            }

            RadioButton {
                id: recoveredRadioButton

                anchors.verticalCenter: parent.verticalCenter
                checked: Globals.Variables.recoveredRadioButtonState

                color: barsetRecovered.color

                text: qsTr("Recovered")

                onToggled: {
                    dataHandler.showConfirmed = !checked
                    dataHandler.showDeaths = !checked
                    dataHandler.showRecovered = checked
                }
            }

            RadioButton {
                id: deathsRadioButton

                anchors.verticalCenter: parent.verticalCenter
                checked: Globals.Variables.deathsRadioButtonState

                color: barsetDeaths.color

                text: qsTr("Deaths")

                onToggled: {
                    dataHandler.showConfirmed = !checked
                    dataHandler.showRecovered = !checked
                    dataHandler.showDeaths = checked
                }
            }
        }

    }

    ////////////////////////////////////////////////////////////////////////

    Rectangle {
        visible: Qt.platform.pluginName === "wasm"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 1
        color: Globals.Colors.appBarBorder
    }
    Rectangle {
        visible: Qt.platform.pluginName === "wasm"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: Globals.Colors.appBarBorder
    }

    ////////////////////////////////////////////////////////////////////////

    Rectangle {
        id: emptyLayer

        anchors.fill: parent
        color: Globals.Colors.mainAreaBackground

        Label {
            anchors.centerIn: parent
            text: "Loading data..."
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    ////////////////////////////////////////////////////////////////////////

    SequentialAnimation
    {
        id: introAnimationBeforeLoadingData

        alwaysRunToEnd: true

        PropertyAction
        {
            target: Globals.Variables
            property: "themeChangeTime"
            value: 0
        }
        PropertyAction
        {
            target: chartView
            property: "animationOptions"
            value: ChartView.NoAnimation
        }
    }

    ////////////////////////////////////////////////////////////////////////

    SequentialAnimation
    {
        id: introAnimationAfterLoadingData

        alwaysRunToEnd: true

        NumberAnimation {
            loops: dataHandler.dataProcessed ? 1 : Animation.Infinite
            duration: Globals.Variables.chartAnimationDuration
        }
        PropertyAction
        {
            target: emptyLayer
            property: "visible"
            value: false
        }
        NumberAnimation
        {
            target: emptyLayer
            property: "opacity"
            to: 0
            duration: Globals.Variables.introAnimationDuration
            easing.type: Easing.OutExpo
        }
        PropertyAction
        {
            target: chartView
            property: "animationOptions"
            value: ChartView.SeriesAnimations
        }
        PropertyAction
        {
            target: Globals.Variables
            property: "themeChangeTime"
            value: 1000
        }
    }

    ////////////////////////////////////////////////////////////////////////

    Settings {
        id: settings
    }

    ////////////////////////////////////////////////////////////////////////

    Component.onCompleted:
    {
        initDebugText()
        loadSettings()

        introAnimationBeforeLoadingData.start()

        dataHandler.loadDataFromLocalResourcesStarted()

        introAnimationAfterLoadingData.start()

        dataHandler.downloadDataFromWebStarted()
        dataHandler.detectClientCountryStarted()
    }

    ////////////////////////////////////////////////////////////////////////

    Component.onDestruction:
    {
        info("saveSettings")

        saveSettings()
    }

    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////

    // Logic

    function loadSettings()
    {
        info("loadSettings")

        appWindow.x = settings.value("appWindowX", Globals.Sizes.appWindowX)
        appWindow.y = settings.value("appWindowY", Globals.Sizes.appWindowY)
        appWindow.width = settings.value("appWindowWidth", Globals.Sizes.appWindowWidth)
        appWindow.height = settings.value("appWindowHeight", Globals.Sizes.appWindowHeight)

        countrySelector.currentIndex = settings.value("countryIndex", Globals.Variables.countryIndex)
        timePeriodSelector.currentIndex = settings.value("timePeriodIndex", Globals.Variables.timePeriodIndex)
        casesSelector.currentIndex = settings.value("casesIndex", Globals.Variables.casesIndex)
        scaleSelector.currentIndex = settings.value("scaleIndex", Globals.Variables.scaleIndex)

        // restore binding
        countrySelector.currentIndex = Qt.binding(function() {return dataHandler.country})
        ///timePeriodSelector.currentIndex = Qt.binding(function() {return dataHandler.timePeriod})
        ///casesSelector.currentIndex = Qt.binding(function() {return dataHandler.cases})
        ///scaleSelector.currentIndex = Qt.binding(function() {return dataHandler.scale})

        /*
        if (casesSelector.currentIndex === DataHandler.TotalCases)
        {
            recoveredCheckBox.checked = settings.value("recoveredCheckBoxState", Globals.Variables.recoveredCheckBoxState)
            deathsCheckBox.checked = settings.value("deathsCheckBoxState", Globals.Variables.deathsCheckBoxState)
            activeCheckBox.checked = settings.value("activeCheckBoxState", Globals.Variables.activeCheckBoxState)
        }
        else if (casesSelector.currentIndex === DataHandler.DailyNewCases)
        {
            if (settings.value("confirmedRadioButtonState", Globals.Variables.confirmedRadioButtonState))
            {
                confirmedRadioButton.checked = true
            }
            if (settings.value("recoveredRadioButtonState", Globals.Variables.recoveredRadioButtonState))
            {
                recoveredRadioButton.checked = true
            }
            if (settings.value("deathsRadioButtonState", Globals.Variables.confirmedRadioButtonState))
            {
                deathsRadioButton.checked = true
            }
        }
        */

        ///dataHandler.cases = scaleSelector.currentIndex

        //Globals.Colors.theme = settings.value("theme", Globals.Colors.systemTheme)
        Globals.Colors.theme = settings.value("theme", Globals.Colors.theme)

        ///print("  confirmedRadioButton", confirmedRadioButton.checked, settings.value("confirmedRadioButtonState", -1))
        ///print("  deathsRadioButton", deathsRadioButton.checked, settings.value("deathsRadioButtonState", -1))
        ///print("  countrySelector.currentIndex", countrySelector.currentIndex, settings.value("countryIndex", -1))
    }

    function saveSettings()
    {
        info("saveSettings")

        settings.setValue("appWindowX", appWindow.x)
        settings.setValue("appWindowY", appWindow.y)
        settings.setValue("appWindowWidth", appWindow.width)
        settings.setValue("appWindowHeight", appWindow.height)

        settings.setValue("appWindowWidth", appWindow.width)
        settings.setValue("appWindowHeight", appWindow.height)

        settings.setValue("countryIndex", countrySelector.currentIndex)
        settings.setValue("timePeriodIndex", timePeriodSelector.currentIndex)
        settings.setValue("casesIndex", casesSelector.currentIndex)
        settings.setValue("scaleIndex", scaleSelector.currentIndex)

        settings.setValue("recoveredCheckBoxState", recoveredCheckBox.checked)
        settings.setValue("deathsCheckBoxState", deathsCheckBox.checked)
        settings.setValue("activeCheckBoxState", activeCheckBox.checked)

        settings.setValue("confirmedRadioButtonState", confirmedRadioButton.checked)
        settings.setValue("recoveredRadioButtonState", recoveredRadioButton.checked)
        settings.setValue("deathsRadioButtonState", deathsRadioButton.checked)

        settings.setValue("theme", Globals.Colors.theme)

        ///print("  confirmedRadioButton", confirmedRadioButton.checked, settings.value("confirmedRadioButtonState", -1))
        ///print("  deathsRadioButton", deathsRadioButton.checked, settings.value("deathsRadioButtonState", -1))
    }

    function initDebugText()
    {
        let s = ""

        s += `Qt.platform.os: ${Qt.platform.os}\n`
        s += `Qt.platform.pluginName: ${Qt.platform.pluginName}\n`

        s += "\n"

        s += `System theme: ${Globals.Colors.systemTheme === Globals.Colors.DarkTheme ? "Dark" : "Light"}\n`

        s += "\n"

        s += `width: ${width}\n`
        s += `Screen.width: ${Screen.width}\n`
        s += `Screen.desktopAvailableWidth: ${Screen.desktopAvailableWidth}\n`

        s += "\n"

        s += `height: ${height.toFixed(3)}\n`
        s += `Screen.height: ${Screen.height}\n`
        s += `Screen.desktopAvailableHeight: ${Screen.desktopAvailableHeight}\n`

        s += "\n"

        s += `Screen.devicePixelRatio: ${Screen.devicePixelRatio}\n`
        s += `Screen.pixelDensity: ${Screen.pixelDensity.toFixed(3)}\n`
        s += `logicalDotsPerInch(): ${_logicalDotsPerInch}\n`
        s += `physicalDotsPerInch(): ${_physicalDotsPerInch.toFixed(3)}\n`

        s += "\n"

        debugTextArea.text = s
    }

    function info(message)
    {
        if (Globals.Variables.loggingLevel >= Globals.Variables.InfoLevel)
        {
            const s = `* ${message}`

            if (Qt.platform.pluginName === "wasm")
            {
                debugTextArea.text += `${s}\n`
            }
            else
            {
                print(s)
            }
        }
    }

    function debug(message)
    {
        if (Globals.Variables.loggingLevel >= Globals.Variables.DebugLevel)
        {
            const s = `  - ${message}`

            if (Qt.platform.pluginName === "wasm")
            {
                debugTextArea.text += `${s}\n`
            }
            else
            {
                print(s)
            }
        }
    }

    function translateDate(date)
    {
        return date
        .replace("Jan", qsTr("Jan"))
        .replace("Feb", qsTr("Feb"))
        .replace("Mar", qsTr("Mar"))
        .replace("Apr", qsTr("Apr"))
        .replace("May", qsTr("May"))
        .replace("Jun", qsTr("Jun"))
        .replace("Jul", qsTr("Jul"))
        .replace("Aug", qsTr("Aug"))
        .replace("Sep", qsTr("Sep"))
        .replace("Oct", qsTr("Oct"))
        .replace("Nov", qsTr("Nov"))
        .replace("Dec", qsTr("Dec"))
    }

}

