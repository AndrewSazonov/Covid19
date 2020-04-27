import QtQuick 2.14

import Globals 1.0 as Globals

PropertyAnimation {
    duration: Globals.Variables.themeChangeTime
    alwaysRunToEnd: true
    easing.type: Easing.OutQuint
}
