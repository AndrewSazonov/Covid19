#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QApplication>
#include <QQmlEngine>
#include <QObject>
#include <QMap>
#include <QTranslator>

class Translator : public QObject
{
    Q_OBJECT

public:
    Translator(QApplication *app, QQmlEngine *engine);

    Q_INVOKABLE void selectLanguage(const QString &language);

private:
    QTranslator *m_translator;
    QApplication *m_app;
    QQmlEngine *m_engine;
    QMap<QString, QString> m_languages;
};

#endif // TRANSLATOR_H

//https://github.com/retifrav/translating-qml
//https://github.com/esutton/qt-translation-example/blob/master/mainwindow.cpp
//https://www.ics.com/webinar/qt-internationalization-localizing-qt-and-qml
//https://www.slideshare.net/ICSinc/qt-internationalization
