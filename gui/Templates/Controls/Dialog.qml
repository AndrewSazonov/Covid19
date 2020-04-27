import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.Dialog {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitHeaderWidth,
                            implicitFooterWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding: Globals.Sizes.fontInPixels * 2
    topPadding: Globals.Sizes.fontInPixels * 1.3
    bottomPadding: Globals.Sizes.fontInPixels * 0.5

    font.family: Globals.Fonts.sans
    font.pixelSize: Globals.Sizes.fontInPixels

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

    background: Rectangle {
        radius: 2

        color: Globals.Colors.dialogBackground
        Behavior on color {
            Animations.ThemeChange {}
        }

        layer.enabled: Globals.Sizes.dialogElevation
        layer.effect: ElevationEffect {
            elevation: Globals.Sizes.dialogElevation
        }
    }

    header: Label {
        text: control.title
        visible: control.title
        elide: Label.ElideRight
        padding: Globals.Sizes.fontInPixels * 1.2
        topPadding: Globals.Sizes.fontInPixels * 1.0
        bottomPadding: 0
        // TODO: QPlatformTheme::TitleBarFont
        font.bold: true
        font.pixelSize: control.font.pixelSize *1.0

        color: Globals.Colors.dialogForeground
        Behavior on color {
            Animations.ThemeChange {}
        }

        background: PaddedRectangle {
            radius: 2
            bottomPadding: -2
            clip: true

            color: Globals.Colors.dialogBackground
            Behavior on color {
                PropertyAnimation {
                    duration: Globals.Variables.themeChangeTime
                    alwaysRunToEnd: true
                    easing.type: Easing.OutQuint
                }
            }
        }
    }

    footer: DialogButtonBox {
        visible: count > 0
    }

    T.Overlay.modal: Rectangle {
        color: Globals.Colors.dialogOutsideBackground
        Behavior on color {
            Animations.ThemeChange {}
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    T.Overlay.modeless: Rectangle {
        color: Globals.Colors.dialogOutsideBackground
        Behavior on color {
            Animations.ThemeChange {}
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }
}
