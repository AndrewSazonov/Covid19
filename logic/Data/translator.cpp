#include <QDebug>

#include "translator.h"

Translator::Translator(QApplication *app, QQmlEngine *engine)
{
    m_translator = new QTranslator(this);
    m_app = app;
    m_engine = engine;
    m_languages["English"] = "en";
    m_languages["Русский"] = "ru";
}

void Translator::selectLanguage(const QString &language)
{
    ///qDebug() << "language" << language << m_languages[language];

    QString languageCode = m_languages[language];
    QString path = QString(":/gui/Resources/Translations/covid19_%1").arg(languageCode);

    ///qDebug() << "***********" << language << languageCode << path;

    if (languageCode == "en") {
        ///qDebug() << "English selected.";
        m_app->removeTranslator(m_translator);
    }
    else if (m_translator->load(path)) {
        ///qDebug() << "Translation file loaded for: " +  language + " (" + languageCode + ")";
        m_app->installTranslator(m_translator);
    }
    else {
        ///qDebug() << "Failed to load translation file, falling back to English.";
        m_app->removeTranslator(m_translator);
    }

    m_engine->retranslate();
}

