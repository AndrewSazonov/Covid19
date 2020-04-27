pragma Singleton

import QtQuick 2.14
import QtQuick.Window 2.14

QtObject {

    // Common
    //property int elevation: 10//Math.round(fontInPixels / 6)

    // Application window
    property int appWindowHeightVerySmall: scalePx(300)
    property int appWindowHeightMedium: scalePx(400)
    property int appWindowHeightLarge: scalePx(460)

    property int appWindowWidthVerySmall: scalePx(300)  // 1 combobox in appBar
    property int appWindowWidthSmall: scalePx(380)      // 2 comboboxes in appBar
    property int appWindowWidthMedium: scalePx(500)     // 3 comboboxes in appBar
    property int appWindowWidthLarge: scalePx(620)      // 4 comboboxes in appBar
    property int appWindowWidthVeryLarge: scalePx(880)  // 4 comboboxes with labels in appBar

    property int appWindowMinimumWidth: appWindowWidthVerySmall
    property int appWindowMinimumHeight: appWindowHeightVerySmall

    property int appWindowWidth: Qt.platform.pluginName === "wasm" ? Screen.width : Math.min(appWindowWidthLarge, Screen.width)
    property int appWindowHeight: Qt.platform.pluginName === "wasm" ? Screen.height : Math.min(appWindowHeightLarge, Screen.height)

    property int appWindowX: Qt.platform.pluginName === "wasm" ? 0 : (Screen.width - appWindowWidth) * 0.5
    property int appWindowY: Qt.platform.pluginName === "wasm" ? 0 : (Screen.height - appWindowHeight) * 0.5

    // Application bar
    property int appBarHeight: Math.round(fontInPixels * 3.5)
    property int appBarSpacing: 16

    // Dialogs
    property int dialogElevation: Math.round(fontInPixels * 2)

    // ComboBox
    property int comboBoxHeight: Math.round(fontInPixels * 2.5)

    // Buttons
    property int buttonHeight: Math.round(fontInPixels * 2.0)
    property int toolButtonHeight: Math.round(fontInPixels * 2.5)

    // Touch
    property int touchSize: Math.round(fontInPixels * 2.0)

    // Fonts
    property int systemFontInPixels: Qt.application.font.pixelSize
    property int fontInPixels: scalePx(Qt.application.font.pixelSize)

    // Scales
    property int defaultScale: 100
    /*
    property real orientationScale: {
        if (Screen.primaryOrientation === Qt.PortraitOrientation ||
            Screen.primaryOrientation === Qt.InvertedPortraitOrientation) {
            return 1.0//1334/750 // iPhone 8 ratio...
        } else if (Screen.primaryOrientation === Qt.LandscapeOrientation ||
                   Screen.primaryOrientation === Qt.InvertedLandscapeOrientation) {
            return 1.0
        } else {
            return 1.0
        }
    }
    */

    // Functions
    function scalePx(size) {
        //return Math.round(size * defaultScale * orientationScale)
        return Math.round(size * (defaultScale / 100))
    }

}

