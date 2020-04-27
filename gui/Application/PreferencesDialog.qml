import QtQuick 2.14
import QtQuick.Controls 2.14

import Globals 1.0 as Globals
import Templates.Controls 1.0
import Templates.Charts 1.0

Dialog {
    //anchors.centerIn: parent

    title: qsTr("Preferences")

    modal: true
    standardButtons: Dialog.Ok

    Column {
        //spacing: Globals.Sizes.fontInPixels * 0.25

        Row {
            spacing: Globals.Sizes.fontInPixels * 0.5

            Label {
                enabled: false
                width: Globals.Sizes.fontInPixels * 6
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Theme") + ":"
            }

            ComboBox {
                width: Globals.Sizes.fontInPixels * 9
                model: [qsTr("Dark"), qsTr("Light")]
                currentIndex: Globals.Colors.theme === Globals.Colors.DarkTheme ? 0 : 1
                onCurrentTextChanged: {
                    if (currentIndex === 0 && Globals.Colors.theme !== Globals.Colors.DarkTheme) {
                        Globals.Colors.theme = Globals.Colors.DarkTheme
                    } else if (currentIndex === 1 && Globals.Colors.theme !== Globals.Colors.LightTheme) {
                        Globals.Colors.theme = Globals.Colors.LightTheme
                    }
                }
            }
        }

        Row {
            spacing: Globals.Sizes.fontInPixels * 0.5

            Label {
                enabled: false
                width: Globals.Sizes.fontInPixels * 6
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Zoom") + ":"
            }

            ComboBox {
                width: Globals.Sizes.fontInPixels * 9
                model: ["100%", "110%", "120%", "130%", "140%", "150%"]
                onCurrentTextChanged: {
                    if (parseInt(currentText) === Globals.Sizes.defaultScale) {
                        return
                    }
                    Globals.Sizes.defaultScale = parseInt(currentText)
                }
            }
        }

        Row {
            spacing: Globals.Sizes.fontInPixels * 0.5

            Label {
                enabled: false
                width: Globals.Sizes.fontInPixels * 6
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Language") + ":"
            }

            ComboBox {
                width: Globals.Sizes.fontInPixels * 9
                model: ["English", "Русский"]

                //onActivated: InterfaceGlobals.Translator.selectLanguage(currentIndex)
                //Component.onCompleted: currentIndex = InterfaceGlobals.Translator.defaultLanguageIndex
                onActivated: {
                    appWindow.saveSettings()
                    _translator.selectLanguage(currentText)
                    appWindow.loadSettings()
                }
            }
        }
    }
}
