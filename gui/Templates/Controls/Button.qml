import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topInset: 6
    bottomInset: 6
    padding: 12
    horizontalPadding: padding - 4
    spacing: 6

    icon.width: 24
    icon.height: 24
    ///icon.color: !enabled ? Material.hintTextColor :
    ///    flat && highlighted ? Material.accentColor :
    ///    highlighted ? Material.primaryHighlightedTextColor : Material.foreground

    ///Material.elevation: flat ? control.down || control.hovered ? 2 : 0
    ///                         : control.down ? 8 : 2
    ///Material.background: flat ? "transparent" : undefined

    flat: true

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font

        color: !control.enabled ?
                   Globals.Colors.themeForegroundDisabled :
                   control.highlighted ?
                       Globals.Colors.themeAccent :
                       Globals.Colors.themeForeground
        Behavior on color {
            Animations.ThemeChange {}
        }
    }

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: Globals.Sizes.buttonHeight

        radius: 2

        color: rippleArea.containsMouse ?
                   (rippleArea.containsPress ?
                        Globals.Colors.appBarButtonBackgroundPressed :
                        Globals.Colors.appBarButtonBackgroundHovered) :
                    Globals.Colors.appBarButtonBackground
        Behavior on color {
            Animations.ThemeChange {}
        }

        MouseArea {
            id: rippleArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: control.clicked()
        }
    }
}
