TEMPLATE = app

# Application name
TARGET = covid19

CONFIG += c++14

# Makes compiler emit warnings if deprecated feature is used
DEFINES += QT_DEPRECATED_WARNINGS

QT += widgets svg qml charts gui quick #gui quick quickcontrols2
#QT += widgets network qml quick quickcontrols2 charts

HEADERS += \
    logic/Data/datahandler.h \
    logic/Data/translator.h

SOURCES += \
    logic/main.cpp \
    logic/Data/datahandler.cpp \
    logic/Data/translator.cpp

TRANSLATIONS += \
    gui/Resources/Translations/covid19_ru.ts

RESOURCES += resources.qrc

# To resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += gui
