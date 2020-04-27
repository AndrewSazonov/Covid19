import QtQuick 2.14
import QtQuick.Templates 2.14 as T

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.Label {
    id: control

    font.family: Globals.Fonts.sans
    font.pixelSize: Globals.Sizes.fontInPixels

    color: enabled ? Globals.Colors.themeForeground : Globals.Colors.themeForegroundDisabled //Material.foreground : Material.hintTextColor
    Behavior on color {
        Animations.ThemeChange {}
    }

    linkColor: Globals.Colors.themeAccent
    Behavior on linkColor {
        Animations.ThemeChange {}
    }
}
