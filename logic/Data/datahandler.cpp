#include <QDate>
#include <QDebug>
#include <QByteArray>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMap>
#include <QMetaEnum>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QString>
#include <QTextStream>
#include <QVariantList>

#include <QtMath>

#include "nicescale.h"
#include "datahandler.h"

DataHandler::DataHandler(QObject *parent)
    : QObject(parent)
{
    connectSignals();

    //loadDataFromLocalResourcesStarted();

    //detectClientCountryStarted();
    //downloadDataFromWebStarted();
}

void DataHandler::connectSignals() const
{
    qDebug() << "connectSignals()";

    connect(this, &DataHandler::countryChanged, this, &DataHandler::onCountryChanged);
    connect(this, &DataHandler::casesChanged, this, &DataHandler::onCasesChanged);
    connect(this, &DataHandler::timePeriodChanged, this, &DataHandler::onTimePeriodChanged);
    connect(this, &DataHandler::scaleChanged, this, &DataHandler::onScaleChanged);

    connect(this, &DataHandler::showConfirmedChanged, this, &DataHandler::onShowConfirmedChanged);
    connect(this, &DataHandler::showRecoveredChanged, this, &DataHandler::onShowRecoveredChanged);
    connect(this, &DataHandler::showActiveChanged, this, &DataHandler::onShowActiveChanged);
    connect(this, &DataHandler::showDeathsChanged, this, &DataHandler::onShowDeathsChanged);

    connect(this, &DataHandler::totalPreprocessed, this, &DataHandler::processData);
    connect(this, &DataHandler::recoveredPreprocessed, this, &DataHandler::processData);
    connect(this, &DataHandler::deathsPreprocessed, this, &DataHandler::processData);

    connect(&m_totalDownloadManager, &QNetworkAccessManager::finished, this, &DataHandler::onDownloadTotalFinished);
    connect(&m_recoveredDownloadManager, &QNetworkAccessManager::finished, this, &DataHandler::onDownloadRecoveredFinished);
    connect(&m_deathsDownloadManager, &QNetworkAccessManager::finished, this, &DataHandler::onDownloadDeathsFinished);
    connect(&m_clientCountryManager, &QNetworkAccessManager::finished, this, &DataHandler::onDetectClientCountryFinished);

    ///connect(this, &DataHandler::dateListChanged, []() { qDebug() << "++++++----*****"; });
    ///connect(this, &DataHandler::countryChanged, [this]() { qDebug() << "____________________________" << m_country; });
    ///connect(this, &DataHandler::casesChanged, [this]() { qDebug() << "____________________________" << m_cases; });
    ///connect(this, &DataHandler::timePeriodChanged, [this]() { qDebug() << "____________________________" << m_timePeriod; });
    ///connect(this, &DataHandler::yMaxChanged, [this]() { qDebug() << "____________________________" << m_yMax; });
    ///connect(this, &DataHandler::loadingStateChanged, [this]() { qDebug() << "____________________________" << m_loadingState; });

}

bool DataHandler::dataProcessed() const
{
    qDebug() << "dataProcessed()" << m_dataProcessed;

    return m_dataProcessed;
}

// ...

void DataHandler::setDataProcessed()
{
    qDebug() << "setDataProcessed()";

    m_dataProcessed = true;

    emit processDataFinished();
}

bool DataHandler::loadingState() const
{
    qDebug() << "loadingState()" << m_loadingState;

    return m_loadingState;
}

bool DataHandler::downloadingState() const
{
    qDebug() << "downloadingState()" << m_downloadingState;

    return m_downloadingState;
}

// ...

bool DataHandler::showConfirmed() const
{
    return m_showConfirmed;
}

void DataHandler::setShowConfirmed(bool showConfirmed)
{
    qDebug() << "setShowConfirmed()" << m_showConfirmed << showConfirmed;

    if (m_showConfirmed == showConfirmed)
        return;

    m_showConfirmed = showConfirmed;

    emit showConfirmedChanged();
}

bool DataHandler::showRecovered() const
{
    qDebug() << "showRecovered()";

    return m_showRecovered;
}

void DataHandler::setShowRecovered(bool showRecovered)
{
    qDebug() << "setShowRecovered()" << m_showRecovered << showRecovered;

    if (m_showRecovered == showRecovered)
        return;

    m_showRecovered = showRecovered;

    emit showRecoveredChanged();
}

bool DataHandler::showDeaths() const
{
    return m_showDeaths;
}

void DataHandler::setShowDeaths(bool showDeaths)
{
    qDebug() << "setShowDeaths()" << m_showDeaths << showDeaths;

    if (m_showDeaths == showDeaths)
        return;

    m_showDeaths = showDeaths;

    emit showDeathsChanged();
}

bool DataHandler::showActive() const
{
    return m_showActive;
}

void DataHandler::setShowActive(bool showActive)
{
    qDebug() << "setShowActive()" << m_showActive << showActive;

    if (m_showActive == showActive)
        return;

    m_showActive = showActive;

    emit showActiveChanged();
}

// ...

int DataHandler::yMax() const
{
    //qDebug() << "yMax()";

    return m_yMax;
}

void DataHandler::updateYMax()
{
    qDebug() << "****updateYMax()";

    if (!m_confirmedArray.length()
            || !m_recoveredArray.length()
            || !m_deathsArray.length()
            || !m_activeArray.length())
        return;

    /*
    if (m_cases == TotalCases)
    {
        for (int i = 0; i < deathsArray.length(); ++i)
        {
            m_deathsArray << deathsArray[i];
        }
    }
    else if (m_cases == DailyNewCases)
    {
        m_deathsArray << 0;
        for (int i = 1; i < deathsArray.length(); ++i)
        {
             m_deathsArray << deathsArray[i] - deathsArray[i-1];
        }
    }
    */

    m_yMax = 1;
    for (int i = m_dateList.length() - m_timePeriodMap[m_timePeriod]; i < m_dateList.length(); ++i)
    {
        //const int confirmedYMax = m_confirmedArray[i].toInt();
        //const int confirmedYMax = m_recoveredArray[i].toInt();
        //const int confirmedYMax = m_deathsArray[i].toInt();
        //const int confirmedYMax = m_confirmedArray[i].toInt();

        int yMax = m_confirmedArray[i].toInt() + m_recoveredArray[i].toInt() + m_deathsArray[i].toInt() + m_activeArray[i].toInt();
        qDebug() << i << m_confirmedArray[i].toInt() << m_recoveredArray[i].toInt() << m_deathsArray[i].toInt() << m_activeArray[i].toInt();

        if (yMax > m_yMax) {
            m_yMax = yMax;
        }
    }

    qDebug() << " m_cases" << m_cases;
    qDebug() << " 001 m_yMax" << m_yMax;


    emit yMaxChanged();

    qDebug() << " 002 yMaxChanged";

}

void DataHandler::setXMinMap()
{
    qDebug() << "setXMinMap()";

    if (m_dateList.length() == 0) {
        return;
    }

    m_xMinMap[TwoWeeksTimePeriod] = m_dateList[m_dateList.length() - m_timePeriodMap[TwoWeeksTimePeriod]];
    m_xMinMap[ThreeWeeksTimePeriod] = m_dateList[m_dateList.length() - m_timePeriodMap[ThreeWeeksTimePeriod]];
    m_xMinMap[OneMonthTimePeriod] = m_dateList[m_dateList.length() - m_timePeriodMap[OneMonthTimePeriod]];
    m_xMinMap[TwoMonthsTimePeriod] = m_dateList[m_dateList.length() - m_timePeriodMap[TwoMonthsTimePeriod]];

    qDebug() << " m_xMinMap" << m_xMinMap;
}

QString DataHandler::xMin() const
{
    qDebug() << "xMin()" << m_xMin;

    return m_xMin;
}

void DataHandler::updateXMin()
{
    qDebug() << "updateXMin()";

    /*
    if (m_timePeriod.isEmpty()) {
        return;
    }

    if (m_xMinMap[m_timePeriod].isEmpty()) {
        return;
    }
    */

    qDebug() << "m_timePeriod" << m_timePeriod;
    qDebug() << "m_xMin before" << m_xMin;
    m_xMin = m_xMinMap[m_timePeriod];
    qDebug() << "m_xMin after" << m_xMin;

    emit xMinChanged();
}

QString DataHandler::xMax() const
{
    //qDebug() << "xMax()";

    return m_xMax;
}

void DataHandler::updateXMax()
{
    qDebug() << "updateXMax()";

    if (m_dateList.isEmpty()) {
        return;
    }

    m_xMax = m_dateList[m_dateList.length() - 1];

    qDebug() << "m_xMax" << m_xMax;

    emit xMaxChanged();
}

// ...

int DataHandler::yTickInterval() const
{
    qDebug() << "yTickInterval()" << m_yTickInterval;

    return m_yTickInterval;
}

const QStringList &DataHandler::yLabels() const
{
    //qDebug() << "yLabels()";

    return m_yLabels;
}

const QStringList &DataHandler::xLabels() const
{
    //qDebug() << "xLabels()";

    return m_xLabels;
}

void DataHandler::updateYLabels()
{
    qDebug() << "-----updateYLabels()";


    qDebug() << " scale" << m_yMin << m_yMax;

    //m_yTickInterval = qFloor(niceScale.tickSpacing);// (int)niceScale.tickSpacing;

    //qDebug() << " m_yTickInterval" << m_yTickInterval;

    //emit yTickIntervalChanged();


    const int ticksCount = 4;
    const qreal yTickInterval = (m_yMax - m_yMin) / (ticksCount - 1);

    m_yLabels.clear();

    for (int i = ticksCount - 1; i >= 0; --i) {

        const qreal tickValue = i * yTickInterval;

        QString tickString = "";
        if (tickValue > 1000000) {
            tickString = QString::number(qRound(tickValue / 1000000)) + "M";
        } else if (tickValue > 1000) {
            tickString = QString::number(qRound(tickValue / 1000)) + "K";
        } else {
            tickString = QString::number(qRound(tickValue));
        }

        m_yLabels << tickString;
    }


    qDebug() << " m_yLabels" << m_yLabels;

    emit yLabelsChanged();
}



/*
void DataHandler::updateYLabels()
{
    qDebug() << "-----updateYLabels()";

    NiceScale niceScale;
    niceScale.setMaxTicks(6);
    niceScale.setMinMaxPoints(m_yMin, m_yMax);

    qDebug() << " scale" << m_yMin << m_yMax;
    qDebug() << " niceScale" << niceScale.niceMin << niceScale.niceMax << niceScale.tickSpacing;

    //m_yTickInterval = qFloor(niceScale.tickSpacing);// (int)niceScale.tickSpacing;

    qDebug() << " m_yTickInterval" << m_yTickInterval;

    //emit yTickIntervalChanged();


    m_yLabels.clear();

    qreal tickValue = niceScale.niceMax;
    while (tickValue >= m_yMin) {
        QString tickString = "";
        if (tickValue > 1000000) {
            tickString = QString::number(tickValue / 1000000) + "M";
        } else if (tickValue > 1000) {
            tickString = QString::number(tickValue / 1000) + "K";
        } else {
            tickString = QString::number(tickValue);
        }
        if (tickValue <= m_yMax) {
            m_yLabels << tickString;
        }
        tickValue -= niceScale.tickSpacing;
    }

    qDebug() << " m_yLabels" << m_yLabels;

    emit yLabelsChanged();
}
*/

void DataHandler::updateXLabels()
{
    qDebug() << "updateXLabels()";

    qDebug() << "m_timePeriod" << m_timePeriod;
    qDebug() << "m_dateList" << m_dateList;

    if (m_dateList.isEmpty()) {
        return;
    }

    m_xLabels.clear();

    for (int i = m_dateList.length() - 1; i >= m_dateList.length() - m_timePeriodMap[m_timePeriod]; --i) {
        int inverseIndex = m_dateList.length() - 1 - i;

        if (m_timePeriod == TwoWeeksTimePeriod) {
            (inverseIndex % 4 == 0) ? m_xLabels.prepend(m_dateList[i]) : m_xLabels.prepend("");
        }

        else if (m_timePeriod == ThreeWeeksTimePeriod) {
            (inverseIndex % 7 == 0) ? m_xLabels.prepend(m_dateList[i]) : m_xLabels.prepend("");
        }

        else if (m_timePeriod == OneMonthTimePeriod) {
            (inverseIndex % 10 == 0) ? m_xLabels.prepend(m_dateList[i]) : m_xLabels.prepend("");
        }

        else if (m_timePeriod == TwoMonthsTimePeriod) {
            (inverseIndex % 20 == 0) ? m_xLabels.prepend(m_dateList[i]) : m_xLabels.prepend("");
        }
    }

    qDebug() << "m_dateList:" << m_dateList;
    qDebug() << "m_xLabels:" << m_xLabels;

    emit xLabelsChanged();
}

// Selectors

DataHandler::Country DataHandler::country() const
{
    return m_country;
}

void DataHandler::setCountry(const Country index)
{
    qDebug() << "setCountry()";
    qDebug() << " index:" << index;

    /*
    if (m_countryList.indexOf(m_country) == index || index == -1)
        return;
    */

    if (m_country == index || index == UnknownCountry) {
        return;
    }

    m_country = index;
    qDebug() << " m_country:" << m_country;

    emit countryChanged();
}

DataHandler::Cases DataHandler::cases() const
{
    qDebug() << "cases()" << m_cases;

    return m_cases;
}

void DataHandler::setCases(const Cases index)
{
    qDebug() << "setCases()";
    qDebug() << " index:" << index;

    /*
    if (m_casesList.indexOf(m_cases) == index || index == -1)
        return;
    */

    if (m_cases == index) {
        return;
    }

    m_cases = index;

    if (m_cases == TotalCases) {
        m_showConfirmed = false;
        m_showRecovered = true;
        m_showDeaths = true;
        m_showActive = true;
    } else if (m_cases == DailyNewCases) {
        m_showConfirmed = true;
        m_showRecovered = false;
        m_showDeaths = false;
        m_showActive = false;
    }

    qDebug() << " m_cases:" << m_cases;


    emit casesChanged();
}

DataHandler::TimePeriod DataHandler::timePeriod() const
{
    qDebug() << " -> get m_timePeriod:" << m_timePeriod;

    return m_timePeriod;
}

void DataHandler::setTimePeriod(const TimePeriod index)
{
    qDebug() << "setTimePeriod()";
    qDebug() << " index:" << index;
    qDebug() << " m_timePeriod:" << m_timePeriod;

    /*
    if (m_timePeriod == index) {
        return;
    }
    */

    if (m_timePeriod == index) {
        return;
    }


    m_timePeriod = index;
    qDebug() << " <- set m_timePeriod:" << m_timePeriod;

    emit timePeriodChanged();
}

DataHandler::Scale DataHandler::scale() const
{
    //qDebug() << "scale()";

    return m_scale;
}

void DataHandler::setScale(const Scale index)
{
    qDebug() << "setScale()";
    qDebug() << " index:" << index;

    /*
    if (m_scaleList.indexOf(m_scale) == index || index == -1)
        return;
    */

    if (m_scale == index) {
        return;
    }

    m_scale = index;

    emit scaleChanged();
}

// Datasets

const QStringList &DataHandler::dateList() const
{
    qDebug() << "dateList()" << m_dateList;

    return m_dateList;
}

void DataHandler::updateDateList()
{
    //processDate();
    //emit dateListChanged();
    //qDebug() << "m_dateList:" << m_dateList;
}


const QVariantList &DataHandler::recoveredArray() const
{
    qDebug() << "recoveredArray()" << m_recoveredArray;

    return m_recoveredArray;
}

void DataHandler::updateConfirmedArray()
{
    qDebug() << "updateConfirmedArray()" << m_showConfirmed;

    /*
    if (m_country.isEmpty()) {
        return;
    }
    */

    qDebug() << " m_country" << m_country;

    QVector<int> confirmedArray = m_confirmedMap[m_country];
    if (confirmedArray.length() == 0)
    {
        return;
    }

    qDebug() << "m_recoveredMap[m_country]" << m_recoveredMap[m_country];

    m_confirmedArray.clear();

    if (m_showConfirmed)
    {
        if (m_cases == TotalCases)
        {
            for (int i = 0; i < confirmedArray.length(); ++i)
            {
                m_confirmedArray << 0; //confirmedArray[i];
            }
        }
        else if (m_cases == DailyNewCases)
        {
            m_confirmedArray << 0;
            for (int i = 1; i < confirmedArray.length(); ++i)
            {
                m_confirmedArray << confirmedArray[i] - confirmedArray[i-1];
            }
        }
    }
    else
    {
        for (int i = 0; i < confirmedArray.length(); ++i)
        {
            m_confirmedArray << 0;
        }
    }

    qDebug() << "m_confirmedArray" << m_confirmedArray;

    emit confirmedArrayChanged();
}

const QVariantList &DataHandler::confirmedArray() const
{
    qDebug() << "confirmedArray()" << m_confirmedArray;

    return m_confirmedArray;
}

void DataHandler::updateRecoveredArray()
{
    qDebug() << "updateRecoveredArray()" << m_showRecovered;

    /*
    if (m_country.isEmpty()) {
        return;
    }
    */

    qDebug() << " m_country" << m_country;

    QVector<int> recoveredArray = m_recoveredMap[m_country];
    if (recoveredArray.length() == 0)
    {
        return;
    }

    qDebug() << "m_recoveredMap[m_country]" << m_recoveredMap[m_country];

    m_recoveredArray.clear();

    if (m_showRecovered)
    {
        if (m_cases == TotalCases)
        {
            for (int i = 0; i < recoveredArray.length(); ++i)
            {
                m_recoveredArray << recoveredArray[i];
            }
        }
        else if (m_cases == DailyNewCases)
        {
            m_recoveredArray << 0;
            for (int i = 1; i < recoveredArray.length(); ++i)
            {
                m_recoveredArray << recoveredArray[i] - recoveredArray[i-1];
            }
        }
    }
    else
    {
        for (int i = 0; i < recoveredArray.length(); ++i)
        {
            m_recoveredArray << 0;
        }
    }

    qDebug() << "m_recoveredArray" << m_recoveredArray;

    emit recoveredArrayChanged();
}

const QVariantList &DataHandler::deathsArray() const
{
    return m_deathsArray;
}

void DataHandler::updateDeathsArray()
{
    qDebug() << "updateDeathsArray()" << m_showDeaths;

    /*
    if (m_country.isEmpty()) {
        return;
    }
    */

    qDebug() << " m_country" << m_country;

    QVector<int> deathsArray = m_deathsMap[m_country];
    if (deathsArray.length() == 0)
    {
        return;
    }

    qDebug() << "m_deathsMap[m_country]" << m_activeMap[m_country];

    m_deathsArray.clear();

    if (m_showDeaths)
    {
        if (m_cases == TotalCases)
        {
            for (int i = 0; i < deathsArray.length(); ++i)
            {
                m_deathsArray << deathsArray[i];
            }
        }
        else if (m_cases == DailyNewCases)
        {
            m_deathsArray << 0;
            for (int i = 1; i < deathsArray.length(); ++i)
            {
                 m_deathsArray << deathsArray[i] - deathsArray[i-1];
            }
        }
    }
    else
    {
        for (int i = 0; i < deathsArray.length(); ++i)
        {
            m_deathsArray << 0;
        }
    }

    qDebug() << "m_deathsArray" << m_deathsArray;

    emit deathsArrayChanged();
}

const QVariantList &DataHandler::activeArray() const
{
    return m_activeArray;
}

void DataHandler::updateActiveArray()
{
    qDebug() << "updateActiveArray()" << m_showActive;

    /*
    if (m_country.isEmpty()) {
        return;
    }
    */

    qDebug() << " m_country" << m_country;

    QVector<int> activeArray = m_activeMap[m_country];
    if (activeArray.length() == 0)
    {
        return;
    }

    qDebug() << "m_activeMap[m_country]" << m_activeMap[m_country];

    m_activeArray.clear();

    if (m_showActive)
    {
        if (m_cases == TotalCases)
        {
            for (int i = 0; i < activeArray.length(); ++i)
            {
                m_activeArray << activeArray[i];
            }
        }
        else if (m_cases == DailyNewCases)
        {
            m_activeArray << 0;
            for (int i = 1; i < activeArray.length(); ++i)
            {
                m_activeArray << 0; //activeArray[i] - activeArray[i-1];
            }
        }
    }
    else
    {
        for (int i = 0; i < activeArray.length(); ++i)
        {
            m_activeArray << 0;
        }
    }

    qDebug() << "m_activeArray" << m_activeArray;

    emit activeArrayChanged();
}

void DataHandler::processData()
{
    qDebug() << "processData()";

    qDebug() << " m_totalReceived" << m_totalReceived << "m_recoveredReceived" << m_recoveredReceived << "m_deathsReceived" << m_deathsReceived;

    if (m_totalReceived != true || m_recoveredReceived != true || m_deathsReceived != true)
        return;

    qDebug() << " m_downloadingState" << m_downloadingState;

    m_loadingState = false;
    emit loadingStateChanged();

    m_downloadingState = false;
    emit downloadingStateChanged();

    processDate();

    processTotal();
    processRecovered();
    processDeaths();
    processActive();

    updateConfirmedArray();
    updateRecoveredArray();
    updateActiveArray();
    updateDeathsArray();

    setXMinMap();

    updateXMin();
    updateXMax();
    updateYMax();

    updateXLabels();
    updateYLabels();

    setDataProcessed();
}


void DataHandler::processDate()
{
    qDebug() << "processDate()";

    qDebug() << " m_country" << m_country;

    m_dateList.clear();
    QStringList list = m_totalHeaders.simplified().split(",");
    for (int i = 4; i < list.length(); ++i) {
        QString stringIn = list[i];
        QString formatIn = "M/d/yy";
        QString formatOut = "d MMM";
        QDate date = QDate::fromString(stringIn, formatIn);
        m_dateList << date.toString(formatOut);
    }

    qDebug() << "m_totalHeaders:" << m_totalHeaders;
    qDebug() << "m_dateList:" << m_dateList;

    emit dateListChanged();
}

void DataHandler::processTotal()
{
    qDebug() << "processTotal()";

    for (const auto &row : m_totalRows) {
        QStringList list = row.split(",");

        QString province = list[0];
        if (!province.isEmpty()) {
            continue;
        }

        QVector<int> data;
        bool ok;
        for (int i = 4; i < list.length(); ++i) {
            int value = list[i].toInt(&ok);
            if (ok) {
                data << value;
            } else {
                data << 0;
            }
        }

        for (int i = 1; i < data.length(); ++i) {
            if (data[i] < data[i-1]) {
                data[i] = data[i-1];
            }
        }

        qDebug() << "m_confirmedMap[country]:" << data;

        const QString countryName = list[1];
        const Country country = m_countryMap.key(countryName, UnknownCountry);
        if (country != UnknownCountry) {
            m_confirmedMap[country] = data;
        }
    }
}

void DataHandler::processRecovered()
{
    qDebug() << "processRecovered()";

    for (const auto &row : m_recoveredRows) {
        QStringList list = row.split(",");

        QString province = list[0];
        if (!province.isEmpty()) {
            continue;
        }

        QVector<int> data;
        bool ok;
        for (int i = 4; i < list.length(); ++i) {
            int value = list[i].toInt(&ok);
            if (ok) {
                data << value;
            } else {
                data << 0;
            }
        }

        for (int i = 1; i < data.length(); ++i) {
            if (data[i] < data[i-1]) {
                data[i] = data[i-1];
            }
        }

        qDebug() << "m_recoveredMap[country]:" << data;

        const QString countryName = list[1];
        const Country country = m_countryMap.key(countryName, UnknownCountry);
        if (country != UnknownCountry) {
            m_recoveredMap[country] = data;
        }
    }
}

void DataHandler::processDeaths()
{
    qDebug() << "processDeaths()";

    for (const auto &row : m_deathsRows) {
        QStringList list = row.split(",");

        QString province = list[0];
        if (!province.isEmpty()) {
            continue;
        }

        QVector<int> data;
        bool ok;
        for (int i = 4; i < list.length(); ++i) {
            int value = list[i].toInt(&ok);
            if (ok) {
                data << value;
            } else {
                data << 0;
            }
        }

        for (int i = 1; i < data.length(); ++i) {
            if (data[i] < data[i-1]) {
                data[i] = data[i-1];
            }
        }

        qDebug() << "m_deathsMap[country]:" << data;

        const QString countryName = list[1];
        const Country country = m_countryMap.key(countryName, UnknownCountry);
        if (country != UnknownCountry) {
            m_deathsMap[country] = data;
        }
    }
}

void DataHandler::processActive()
{
    qDebug() << "processActive()";

    for (const Country &country : m_confirmedMap.keys()) {
        QVector<int> total = m_confirmedMap[country];
        QVector<int> recovered = m_recoveredMap[country];
        QVector<int> deaths = m_deathsMap[country];

        QVector<int> data;
        for (int i = 0; i < total.length(); ++i) {
            data << total[i] - recovered[i] - deaths[i];
        }

        m_activeMap[country] = data;
    }
}

// Files

void DataHandler::loadDataFromLocalResourcesStarted()
{
    qDebug() << "loadDataFromLocalResourcesStarted()";

    m_loadingState = true;
    emit loadingStateChanged();

    m_totalReceived = false;
    m_recoveredReceived = false;
    m_deathsReceived = false;

    loadTotal();
    loadRecovered();
    loadDeaths();
}

void DataHandler::loadTotal()
{
    qDebug() << "loadTotal()";

    QFile file(m_totalPath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;

    QByteArray content = file.readAll();

    preprocessTotal(content);
}

void DataHandler::loadRecovered()
{
    qDebug() << "loadRecovered()";

    QFile file(m_recoveredPath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;

    QByteArray content = file.readAll();

    preprocessRecovered(content);
}

void DataHandler::loadDeaths()
{
    qDebug() << "loadDeaths()";

    QFile file(m_deathsPath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;

    QByteArray content = file.readAll();

    preprocessDeaths(content);
}

void DataHandler::downloadTotalStarted()
{
    qDebug() << "downloadTotalStarted()";

    m_totalDownloadManager.get(QNetworkRequest(QUrl(m_totalUrl)));
}

void DataHandler::downloadRecoveredStarted()
{
    qDebug() << "downloadRecoveredStarted()";

    m_recoveredDownloadManager.get(QNetworkRequest(QUrl(m_recoveredUrl)));
}

void DataHandler::downloadDeathsStarted()
{
    qDebug() << "downloadDeathsStarted()";

    m_deathsDownloadManager.get(QNetworkRequest(QUrl(m_deathsUrl)));
}

void DataHandler::onDownloadTotalFinished(QNetworkReply *reply)
{
    qDebug() << "onDownloadTotalFinished()";

    qDebug() << "reply->error()" << reply->error();

    if (reply->error() != QNetworkReply::NoError)
        return;

    const QByteArray content = reply->readAll();

    preprocessTotal(content);
}

void DataHandler::onDownloadRecoveredFinished(QNetworkReply *reply)
{
    qDebug() << "onDownloadRecoveredFinished()";

    qDebug() << "reply->error()" << reply->error();

    if (reply->error() != QNetworkReply::NoError)
        return;

    const QByteArray content = reply->readAll();

    preprocessRecovered(content);
}

void DataHandler::onDownloadDeathsFinished(QNetworkReply *reply)
{
    qDebug() << "onDownloadDeathsFinished()";

    qDebug() << "reply->error()" << reply->error();

    if (reply->error() != QNetworkReply::NoError)
        return;

    const QByteArray content = reply->readAll();

    preprocessDeaths(content);
}

void DataHandler::preprocessTotal(const QByteArray &rawContent)
{
    qDebug() << "preprocessTotal()";

    QStringList list = QString::fromLocal8Bit(rawContent).split('\n', QString::SkipEmptyParts);

    m_totalHeaders = list[0];

    m_totalRows.clear();
    for (int i = 1; i < list.length(); ++i) {
        m_totalRows << list[i];
    }

    m_totalReceived = true;

    emit totalPreprocessed();
}

void DataHandler::preprocessRecovered(const QByteArray &rawContent)
{
    qDebug() << "preprocessRecovered()";

    QStringList list = QString::fromLocal8Bit(rawContent).split('\n', QString::SkipEmptyParts);

    m_recoveredHeaders = list[0];

    m_recoveredRows.clear();
    for (int i = 1; i < list.length(); ++i) {
        m_recoveredRows << list[i];
    }

    m_recoveredReceived = true;

    emit recoveredPreprocessed();
}

void DataHandler::preprocessDeaths(const QByteArray &rawContent)
{
    qDebug() << "preprocessDeaths()";

    QStringList list = QString::fromLocal8Bit(rawContent).split('\n', QString::SkipEmptyParts);

    m_deathsHeaders = list[0];

    m_deathsRows.clear();
    for (int i = 1; i < list.length(); ++i) {
        m_deathsRows << list[i];
    }

    m_deathsReceived = true;
    emit deathsPreprocessed();
}

void DataHandler::downloadDataFromWebStarted()
{
    qDebug() << "downloadDataFromWebStarted()";

    m_downloadingState = true;
    emit downloadingStateChanged();

    m_totalReceived = false;
    m_recoveredReceived = false;
    m_deathsReceived = false;

    downloadTotalStarted();
    downloadRecoveredStarted();
    downloadDeathsStarted();
}


void DataHandler::detectClientCountryStarted()
{
    qDebug() << "detectClientCountryStarted()";

    // https://medium.com/@ipdata_co/what-is-the-best-commercial-ip-geolocation-api-d8195cda7027

    // "https://ipapi.co/json" -> "country_name" : works, but show divide by zero runtime error in browsers
    // "https://api.ipdata.co/?api-key=test" -> "country_name" : works
    // "https://ip-api.com/json" -> "country" : not checked yet
    // "http://ipgeolocation.com/?json=1" -> "country" : not checked yet
    // "https://api.ipgeolocationapi.com/geolocate" -> "name" : not checked yet

    m_clientCountryManager.get(QNetworkRequest(QUrl("http://ipgeolocation.com/?json=1")));
}

void DataHandler::onDetectClientCountryFinished(QNetworkReply *reply)
{
    qDebug() << "onDetectClientCountryFinished()";

    qDebug() << " reply->error()" << reply->error();

    if (reply->error() != QNetworkReply::NoError)
        return;

    const QByteArray content = reply->readAll();

    qDebug() << " content" << content;

    setClientCountry(content);
}

void DataHandler::setClientCountry(const QByteArray &rawContent)
{
    qDebug() << "setClientCountry()";

    const QStringList list = QString::fromLocal8Bit(rawContent).split('\n', QString::SkipEmptyParts);

    qDebug() << " list" << list;

    const QJsonDocument json = QJsonDocument::fromJson(rawContent);
    const QJsonObject root = json.object();
    const QString countryName = root.value("country").toString();
    const Country country = m_countryMap.key(countryName, UnknownCountry);

    qDebug() << " countryName" << countryName;
    qDebug() << " country" << country;

    setCountry(country);
}

// Slots

void DataHandler::onCountryChanged()
{
    qDebug() << "onCountryChanged()";

    updateConfirmedArray();
    updateRecoveredArray();
    updateActiveArray();
    updateDeathsArray();
    updateYMax();
    updateYLabels();
}

void DataHandler::onTimePeriodChanged()
{
    updateXMin();
    updateXMax();
    updateYMax();
    updateXLabels();
    updateYLabels();
}

void DataHandler::onCasesChanged()
{
    updateConfirmedArray();
    updateRecoveredArray();
    updateActiveArray();
    updateDeathsArray();
    updateYMax();
    updateYLabels();
}

void DataHandler::onScaleChanged()
{
    updateConfirmedArray();
    updateRecoveredArray();
    updateActiveArray();
    updateDeathsArray();
    updateYMax();
    updateYLabels();
}

void DataHandler::onShowConfirmedChanged()
{
    qDebug() << "onShowConfirmedChanged()";

    updateConfirmedArray();
    updateYMax();
    updateYLabels();
}

void DataHandler::onShowRecoveredChanged()
{
    qDebug() << "onShowRecoveredChanged()";

    updateRecoveredArray();
    updateYMax();
    updateYLabels();
}

void DataHandler::onShowActiveChanged()
{
    qDebug() << "onShowActiveChanged()";

    updateActiveArray();
    updateYMax();
    updateYLabels();
}

void DataHandler::onShowDeathsChanged()
{
    qDebug() << "onShowDeathsChanged()";

    updateDeathsArray();
    updateYMax();
    updateYLabels();
}

