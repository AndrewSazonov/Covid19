import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.ToolButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding)

    padding: 0
    spacing: 0
    leftInset: 0
    rightInset: 0
    topInset: 0
    bottomInset: 0

    //ToolTip.visible: hovered && ToolTip.text !== ""

    /*
    ToolTip {
        text: ToolTip.text
        visible: control.parent.hovered//hovered && ToolTip.text !== ""
    }
    */

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text

        font.family: Globals.Fonts.icons
        font.pixelSize: control.font.pixelSize * 1.25

        color: !control.enabled ?
                   Globals.Colors.themeForegroundDisabled :
                   control.checked || control.highlighted ?
                        Globals.Colors.themeAccent :
                        Globals.Colors.themeForeground
        Behavior on color {
            Animations.ThemeChange {}
        }
    }

    background: Rectangle {
        implicitWidth: Globals.Sizes.toolButtonHeight
        implicitHeight: Globals.Sizes.toolButtonHeight
        radius: Globals.Sizes.toolButtonHeight * 0.5
        color: rippleArea.containsMouse ?
                   (rippleArea.containsPress ?
                        Globals.Colors.appBarButtonBackgroundPressed :
                        Globals.Colors.appBarButtonBackgroundHovered) :
                    Globals.Colors.appBarButtonBackground
        Behavior on color {
            PropertyAnimation {
                duration: rippleArea.containsMouse ? 500 : 0 //Globals.Variables.themeChangeTime
                alwaysRunToEnd: true
                easing.type: Easing.OutCubic
            }
        }

        MouseArea {
            id: rippleArea
            anchors.fill: parent
            hoverEnabled: true
            //onClicked: control.clicked()
            onPressed: mouse.accepted = false
        }
    }
}
