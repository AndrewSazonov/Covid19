import QtQuick 2.14

import Globals 1.0 as Globals

SequentialAnimation {

    // Animation with old text
    ParallelAnimation {
        NumberAnimation {
            target: parent
            property: "opacity"
            to: 0
            duration: Globals.Variables.translationChangeTime
            easing.type: Easing.InCirc
        }
    }

    // Text changed
    PropertyAction {}

    // Animation with new text
    ParallelAnimation {
        NumberAnimation {
            target: parent
            property: "opacity"
            to: 1
            duration: Globals.Variables.translationChangeTime
            easing.type: Easing.OutCirc
        }
    }
}
