import QtQuick 2.14
import QtQuick.Templates 2.14 as T

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.ToolTip {
    id: control

    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: -implicitHeight - 24

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    margins: 12
    padding: 8
    horizontalPadding: padding + 8

    closePolicy: T.Popup.CloseOnEscape |
                 T.Popup.CloseOnPressOutsideParent |
                 T.Popup.CloseOnReleaseOutsideParent

    font.family: Globals.Fonts.sans
    font.pixelSize: Globals.Sizes.fontInPixels*2

    ///Material.theme: Material.Dark

    contentItem: Label {
        text: control.text
        font: control.font
        ///color: control.Material.foreground
        color: Globals.Colors.themeForeground
    }

    background: Rectangle {
        ///implicitHeight: control.Material.tooltipHeight
        ///color: control.Material.tooltipColor
        color: Globals.Colors.dialogBackground
        opacity: 0.9
        radius: 2
    }

    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            easing.type: Easing.OutQuad
            duration: 500
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            easing.type: Easing.InQuad
            duration: 500
        }
    }
}

