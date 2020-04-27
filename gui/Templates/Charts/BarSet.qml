import QtQuick 2.14
import QtCharts 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations

BarSet {
    borderColor: "transparent"

    Behavior on borderColor {
        Animations.ThemeChange {}
    }
}
