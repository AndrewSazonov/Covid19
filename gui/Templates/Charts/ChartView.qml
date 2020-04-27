import QtQuick 2.14
import QtCharts 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations

ChartView {
    id: chart

    margins.top: 0
    margins.bottom: 0
    margins.left: 0
    margins.right: 0

    antialiasing: true

    //theme: Globals.Colors.chartTheme
    animationDuration: Globals.Variables.chartAnimationDuration
    animationOptions: ChartView.SeriesAnimations

    legend.visible: false
    legend.alignment: Qt.AlignBottom
    legend.font.family: Globals.Fonts.sans
    legend.font.pixelSize: Globals.Sizes.fontInPixels
    legend.markerShape: Legend.MarkerShapeRectangle
    legend.labelColor: Globals.Colors.chartForeground
    Behavior on legend.labelColor {
        Animations.ThemeChange {}
    }

    backgroundRoundness: 0
    backgroundColor: Globals.Colors.chartBackground
    Behavior on backgroundColor {
        Animations.ThemeChange {}
    }

    titleFont.family: Globals.Fonts.sans
    titleFont.pixelSize: Globals.Sizes.fontInPixels
    titleFont.bold: true
    titleColor: Globals.Colors.chartForeground
    /* BREAKS ANIMATION !
    Behavior on titleColor {
        Animations.ThemeChange {}
    }
    */

    plotAreaColor: Globals.Colors.chartPlotAreaBackground
    Behavior on plotAreaColor {
        Animations.ThemeChange {}
    }

    // Plot axes rect
    /*
    Rectangle {
        x: plotArea.x
        y: plotArea.y
        height: 1
        width: plotArea.width

        visible: false

        //opacity: chart.opacity

        color: Globals.Colors.appBorder
        Behavior on color {
            Animations.ThemeChange {}
        }
    }
    Rectangle {
        x: plotArea.x
        y: plotArea.y + plotArea.height
        height: 1
        width: plotArea.width

        visible: false

        //opacity: chart.opacity

        color: Globals.Colors.appBorder
        Behavior on color {
            Animations.ThemeChange {}
        }
    }
    Rectangle {
        x: plotArea.x
        y: plotArea.y
        height: plotArea.height
        width: 1

        visible: false

        //opacity: chart.opacity

        color: Globals.Colors.appBorder
        Behavior on color {
            Animations.ThemeChange {}
        }
    }
    Rectangle {
        y: plotArea.y
        x: plotArea.x + plotArea.width
        height: plotArea.height
        width: 1

        visible: false

        //opacity: chart.opacity

        color: Globals.Colors.appBorder
        Behavior on color {
            Animations.ThemeChange {}
        }
    }
    */
}
