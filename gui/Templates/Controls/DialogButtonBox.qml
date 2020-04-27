import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14

import Globals 1.0 as Globals
import Templates.Animations 1.0 as Animations
import Templates.Controls 1.0

T.DialogButtonBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 8
    padding: 8
    verticalPadding: 2
    alignment: Qt.AlignRight
    buttonLayout: T.DialogButtonBox.AndroidLayout

    ///Material.foreground: Material.accent

    delegate: Button { highlighted: true }

    contentItem: ListView {
        model: control.contentModel
        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
    }

    // Buttons area
    background: PaddedRectangle {
        ///implicitHeight: control.Material.dialogButtonBoxHeight
        radius: 2
        // Rounded corners should be only at the top or at the bottom
        topPadding: control.position === T.DialogButtonBox.Footer ? -2 : 0
        bottomPadding: control.position === T.DialogButtonBox.Header ? -2 : 0
        clip: true

        color: Globals.Colors.dialogBackground
        Behavior on color {
            Animations.ThemeChange {}
        }
    }
}
