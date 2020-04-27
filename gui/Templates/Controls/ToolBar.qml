import QtQuick 2.14
import QtQuick.Templates 2.14 as T

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.ToolBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: Globals.Sizes.appBarSpacing

    font.family: Globals.Fonts.sans
    font.pixelSize: Globals.Sizes.fontInPixels

    background: Rectangle {
        implicitHeight: Globals.Sizes.appBarHeight

        color: Globals.Colors.appBarBackground


        Behavior on color {
            Animations.ThemeChange {}
        }

        ///layer.enabled: control.Material.elevation > 0
        ///layer.effect: ElevationEffect {
        ///    elevation: control.Material.elevation
        ///    fullWidth: true
        ///}

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: 1

            color: Globals.Colors.appBarBorder
            ///color: control.Material.toolBarColor
            Behavior on color {
                Animations.ThemeChange {}
            }
        }
    }    
}
