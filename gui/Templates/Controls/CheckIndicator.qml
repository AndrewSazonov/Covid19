import QtQuick 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

Rectangle {
    id: indicatorItem

    implicitWidth: Globals.Sizes.fontInPixels
    implicitHeight: Globals.Sizes.fontInPixels

    radius: 2

    color: "transparent"
    ///border.color: !control.enabled ? control.Material.hintTextColor
    ///    : checkState !== Qt.Unchecked ? control.Material.accentColor : control.Material.secondaryTextColor
    border.width: checkState !== Qt.Unchecked ? width / 2 : 2

    property Item control
    property int checkState: control.checkState

    Behavior on border.width {
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutCubic
        }
    }

    /*
    Behavior on border.color {
        ColorAnimation {
            duration: 100
            easing.type: Easing.OutCubic
        }
    }
    */

    Label {
        id: checkSymbol

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        text: "\ue800"

        font.family: Globals.Fonts.icons
        font.pixelSize: Globals.Sizes.fontInPixels

        scale: indicatorItem.checkState === Qt.Checked ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 100 } }

        color: indicatorItem.enabled ?
                   Globals.Colors.checkSymbol :
                   Globals.Colors.themeForegroundDisabled
        Behavior on color {
            Animations.ThemeChange {}
        }
    }

    Rectangle {
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 12
        height: 3

        scale: indicatorItem.checkState === Qt.PartiallyChecked ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 100 } }
    }

    states: [
        State {
            name: "checked"
            when: indicatorItem.checkState === Qt.Checked
        },
        State {
            name: "partiallychecked"
            when: indicatorItem.checkState === Qt.PartiallyChecked
        }
    ]

    transitions: Transition {
        SequentialAnimation {
            NumberAnimation {
                target: indicatorItem
                property: "scale"
                // Go down 2 pixels in size.
                to: 1 - 2 / indicatorItem.width
                duration: 120
            }
            NumberAnimation {
                target: indicatorItem
                property: "scale"
                to: 1
                duration: 120
            }
        }
    }
}
