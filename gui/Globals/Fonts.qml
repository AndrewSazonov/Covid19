pragma Singleton

import QtQuick 2.14

QtObject {

    // Load fonts
    property FontLoader ptSansWebRegular: FontLoader {
        source: "qrc:/gui/Resources/Font/PtSans/PT_Sans-Web-Regular.ttf"
    }
    property FontLoader ptSansWebBold: FontLoader {
        source: "qrc:/gui/Resources/Font/PtSans/PT_Sans-Web-Bold.ttf"
    }
    property FontLoader awesomeFontSelected: FontLoader {
        source: "qrc:/gui/Resources/Font/FontAwesome/font_awesome_selected.ttf"
    }

    // Font parameters
    readonly property string sans: ptSansWebRegular.name
    readonly property string icons: awesomeFontSelected.name

}
