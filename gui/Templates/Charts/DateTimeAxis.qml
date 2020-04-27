import QtQuick 2.14
import QtCharts 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations

DateTimeAxis {
    lineVisible: false // Hide axes lines (only grid is visible)

    color: Globals.Colors.appBorder
    Behavior on color {
        Animations.ThemeChange {}
    }

    gridLineColor: Globals.Colors.appBorder
    Behavior on gridLineColor {
        Animations.ThemeChange {}
    }

    minorGridLineColor: Globals.Colors.themeBackground
    Behavior on minorGridLineColor {
        Animations.ThemeChange {}
    }

    labelsColor: Globals.Colors.chartForeground
    Behavior on labelsColor {
        Animations.ThemeChange {}
    }

    labelsFont.family: Globals.Fonts.sans
    labelsFont.pixelSize: Globals.Sizes.fontInPixels
    titleFont.family: Globals.Fonts.sans
    titleFont.pixelSize: Globals.Sizes.fontInPixels
    titleFont.bold: true
}
