import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Templates 2.14 as T

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.ApplicationWindow {
    visible: true
    flags: Globals.Variables.appWindowFlags

    //minimumWidth: Globals.Sizes.appWindowMinimumWidth
    //minimumHeight: Globals.Sizes.appWindowMinimumHeight

    x: Globals.Sizes.appWindowX
    y: Globals.Sizes.appWindowY

    width: Globals.Sizes.appWindowWidth
    height: Globals.Sizes.appWindowHeight

    font.family: Globals.Fonts.sans
    font.pixelSize: Globals.Sizes.fontInPixels

    color: Globals.Colors.mainAreaBackground
    Behavior on color {
        Animations.ThemeChange {}
    }
}
