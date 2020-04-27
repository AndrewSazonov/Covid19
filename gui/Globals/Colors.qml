pragma Singleton

import QtQuick 2.14
import QtQuick.Controls.Material 2.14

// 1st decision: Desided not to use enum, because to access it within this file one need to write:
// Color.Themes.LightTheme (Color comes from the name of the current file - Color.qml)
// However, Color is also a standard QML library in QtQuick - so we get a conflict ??? (wasm freezes???)
// 2nd decision: Rename this file to Colors.qml instead of Color.qml...

QtObject {

    // Theme
    enum Themes { DarkTheme = 0, LightTheme }

    property int theme: Colors.Themes.DarkTheme
    property bool isDarkTheme: theme === Colors.Themes.DarkTheme

    property color themeAccent: isDarkTheme ? "#4ec1ef": "#00a3e3"
    property color themePrimary: isDarkTheme ? "#222" : "#ddd"
    property color themeBackground: isDarkTheme ? "#333" : "#e9e9e9"
    property color themeForeground: isDarkTheme ? "#eee" : "#333"
    property color themeForegroundDisabled: isDarkTheme ? "#888": "#999" // control.Material.hintTextColor

    // System theme
    property var _systemThemeChecker: Item { Material.theme: Material.System }
    property int systemTheme: _systemThemeChecker.Material.theme === Material.Dark ?
                                  Colors.Themes.DarkTheme :
                                  Colors.Themes.LightTheme

    // Ripple
    property color rippleColorHovered: isDarkTheme ? "#75666666" : "#75999999"
    property color rippleColorPressed: isDarkTheme ? "#75777777" : "#75888888"

    // Application window
    property color appBorder: isDarkTheme ? "#262626" : "#ddd"

    // Application bar (on top of the application window)
    property color appBarBackground: themeBackground
    property color appBarForeground: isDarkTheme ? "#eee" : "#222"
    property color appBarBorder: isDarkTheme ? "#2e2e2e" : "#d6d6d6"

    property color appBarButtonBackground: "transparent"
    property color appBarButtonBackgroundHovered: isDarkTheme ? "#50666666" : "#20666666"
    property color appBarButtonBackgroundPressed: isDarkTheme ? "#90666666" : "#40666666"
    property color appBarButtonForeground: isDarkTheme ? "#ccc" : "#444"

    property color appBarComboBoxBackground: isDarkTheme ? "#10666666" : "#70ffffff"
    property color appBarComboBoxBackgroundHovered: isDarkTheme ? "#50666666" : "#bbffffff"
    property color appBarComboBoxBackgroundPressed: isDarkTheme ? "#90666666" : "#ffffffff"
    property color appBarComboBoxBorder: isDarkTheme ? Qt.darker(appBarBackground, 1.1) : Qt.darker(appBarBackground, 1.05)

    // Main area
    property color mainAreaBackground: isDarkTheme ? "#3a3a3a" : "#f4f4f4"

    // Chart areas
    property color chartForeground: themeForeground
    property color chartBackground: "transparent"
    property color chartPlotAreaBackground: "transparent"
    property color confirmed: Qt.rgba(205/255, 133/255, 63/255, 0.75)
    property color recovered: Qt.rgba(99/256, 191/256, 102/256, 0.75)
    property color deaths: Qt.rgba(255/256, 105/256, 94/256, 0.75)
    property color active: Qt.rgba(42/256, 153/256, 217/256, 0.75)
    property color confirmedText: isDarkTheme ? Qt.lighter(Qt.rgba(205/255, 133/255, 63/255, 1.0), 1.5) : Qt.darker(Qt.rgba(205/255, 133/255, 63/255, 1.0), 1.4)
    property color recoveredText: isDarkTheme ? Qt.lighter(Qt.rgba(99/256, 191/256, 102/256, 1.0), 1.5) : Qt.darker(Qt.rgba(99/256, 191/256, 102/256, 1.0), 1.3)
    property color deathsText: isDarkTheme ? Qt.lighter(Qt.rgba(255/256, 105/256, 94/256, 1.0), 1.2) : Qt.darker(Qt.rgba(255/256, 105/256, 94/256, 1.0), 1.5)
    property color activeText: isDarkTheme ? Qt.lighter(Qt.rgba(42/256, 153/256, 217/256, 1.0), 1.6) : Qt.darker(Qt.rgba(42/256, 153/256, 217/256, 1.0), 1.4)

    // Dialogs
    //property color dialogBackground: isDarkTheme ? "#80000000" : "#80ffffff"
    property color dialogBackground: themeBackground//isDarkTheme ? "#80000000" : "#80ffffff"
    property color dialogOutsideBackground: isDarkTheme ? "#80000000" : "#80ffffff"
    property color dialogForeground: themeForeground

    // CheckBox
    property color checkSymbol: isDarkTheme ? "#ddd" : "#fff"

    // Images
    property string appLogoSrc: isDarkTheme ?
                                    "qrc:/gui/Resources/Image/LogoForDark.svg" :
                                    "qrc:/gui/Resources/Image/LogoForLight.svg"

}
