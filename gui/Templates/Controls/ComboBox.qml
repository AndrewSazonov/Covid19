import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import QtQuick.Templates 2.14 as T

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.ComboBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    topInset: Globals.Sizes.fontInPixels * 0.5
    bottomInset: Globals.Sizes.fontInPixels * 0.5

    leftPadding: padding + (!control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    rightPadding: padding + (control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)

    ///Material.elevation: flat ? 0 : control.pressed ? 8 : 2
    ///Material.background: flat ? Globals.Colors.mainAreaBackground : undefined
    ///Material.foreground: flat ? undefined : Material.primaryTextColor

    font.family: Globals.Fonts.sans
    font.pixelSize: Globals.Sizes.fontInPixels

    flat: true
    hoverEnabled: true
    editable: false

    delegate: MenuItem {
        width: parent.width
        height: Globals.Sizes.comboBoxHeight

        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        ///Material.foreground: control.currentIndex === index ? parent.Material.accent : parent.Material.foreground
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
    }

    indicator: Label {
        x: control.mirrored ? control.padding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2

        text: "\ue801"

        font.family: Globals.Fonts.icons
        font.pixelSize: Globals.Sizes.fontInPixels

        ///color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
        color: control.enabled ? Globals.Colors.themeForeground :  Globals.Colors.themeForegroundDisabled
        Behavior on color {
            Animations.ThemeChange {}
        }
    }

    contentItem: T.TextField {
        padding: Globals.Sizes.fontInPixels * 0.5
        leftPadding: control.editable ? 2 : control.mirrored ? 0 : 12
        rightPadding: control.editable ? 2 : control.mirrored ? 12 : 0

        /////height: 20

        text: control.editable ? control.editText : control.displayText

        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator

        font: control.font
        verticalAlignment: Text.AlignVCenter

        ///selectionColor: control.Material.accentColor
        ///selectedTextColor: control.Material.primaryHighlightedTextColor

        ///color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
        color: control.enabled ? Globals.Colors.themeForeground :  Globals.Colors.themeForegroundDisabled
        Behavior on color {
            Animations.ThemeChange {}
        }

        cursorDelegate: CursorDelegate { }
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: Globals.Sizes.comboBoxHeight

        radius: control.flat ? 0 : 2

        ///color: !control.editable ? control.Material.dialogColor : "transparent"
        color: control.hovered ?
                   (control.pressed ?
                        Globals.Colors.appBarComboBoxBackgroundPressed :
                        Globals.Colors.appBarComboBoxBackgroundHovered) :
                    Globals.Colors.appBarComboBoxBackground
        Behavior on color {
            Animations.ThemeChange {}
        }

        border.color: Globals.Colors.appBarComboBoxBorder
        Behavior on border.color {
            Animations.ThemeChange {}
        }
    }

    popup: T.Popup {
        y: control.editable ? control.height - 5 : 0
        width: control.width
        height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
        transformOrigin: Item.Top
        topMargin: Globals.Sizes.fontInPixels
        bottomMargin: Globals.Sizes.fontInPixels

        ///Material.theme: control.Material.theme
        ///Material.accent: control.Material.accent
        ///Material.primary: control.Material.primary

        enter: Transition {
            // grow_fade_in
            NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        exit: Transition {
            // shrink_fade_out
            NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0

            T.ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            radius: 2
            color: Globals.Colors.dialogBackground
            ///color: parent.Material.dialogColor
            Behavior on color {
                PropertyAnimation {
                    duration: Globals.Variables.themeChangeTime
                    alwaysRunToEnd: true
                    easing.type: Easing.OutQuint
                }
            }

            layer.enabled: control.enabled
            layer.effect: ElevationEffect {
                elevation: 8
            }
        }
    }
}
