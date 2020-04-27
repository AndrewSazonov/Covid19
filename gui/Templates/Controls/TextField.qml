import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14

T.TextField {
    id: control

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                   || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    topPadding: 8
    bottomPadding: 16

    ///color: enabled ? Material.foreground : Material.hintTextColor
    ///selectionColor: Material.accentColor
    ///selectedTextColor: Material.primaryHighlightedTextColor
    ///placeholderTextColor: Material.hintTextColor
    verticalAlignment: TextInput.AlignVCenter

    cursorDelegate: CursorDelegate { }

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        elide: Text.ElideRight
        renderType: control.renderType
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
    }

    background: Rectangle {
        y: control.height - height - control.bottomPadding + 8
        implicitWidth: 120
        height: control.activeFocus || control.hovered ? 2 : 1
        ///color: control.activeFocus ? control.Material.accentColor
        ///                           : (control.hovered ? control.Material.primaryTextColor : control.Material.hintTextColor)
    }
}
