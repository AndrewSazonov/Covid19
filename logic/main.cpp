#include <QApplication>
#include <QDebug>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QScreen>
#include <QTranslator>

#include "Data/datahandler.h"
#include "Data/translator.h"


#include <qapplication.h>
#include <stdio.h>
#include <stdlib.h>

// https://doc.qt.io/qt-5/qtglobal.html#qInstallMessageHandler
void customMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QByteArray localMsg = msg.toLocal8Bit();
    const char *category = QString(context.category) == "qml" ? "qml" : "cpp";
    const char *color = QString(context.category) == "qml" ? "\033[32;1m" : "\033[33;1m";
    const char *reset = "\033[0m";
    fprintf(stderr, "%s%s: %s%s\n", color, category, localMsg.constData(), reset);
}

int main(int argc, char *argv[])
{
    // https://doc.qt.io/qt-5/qml-qtqml-qt.html#qmlglobalqtobject
    // https://wiki.qt.io/Qt_for_WebAssembly

    //QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "1");

    qInstallMessageHandler(customMessageOutput);

    qmlRegisterType<DataHandler>("Data", 1, 0, "DataHandler");

    QApplication app(argc, argv);
    app.setApplicationName("Covidist");
    app.setOrganizationName("Apptimity");
    app.setOrganizationDomain("apptimity.com");
    app.setWindowIcon(QIcon(":/gui/Resources/Icon/App.svg"));

    QQmlApplicationEngine engine;
    Translator translator(&app, &engine); // global qApp can be used instead of &app

    engine.rootContext()->setContextProperty("_translator", &translator);
    engine.rootContext()->setContextProperty("_logicalDotsPerInch", QGuiApplication::primaryScreen()->logicalDotsPerInch());
    engine.rootContext()->setContextProperty("_physicalDotsPerInch", QGuiApplication::primaryScreen()->physicalDotsPerInch());

    engine.addImportPath(":/gui");
    engine.load("qrc:/gui/main.qml");

    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
