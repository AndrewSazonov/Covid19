#ifndef DATAHANDLER_H
#define DATAHANDLER_H

#include <QNetworkAccessManager>
#include <QObject>
#include <QNetworkReply>
#include <QVariantList>

class DataHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool dataProcessed READ dataProcessed NOTIFY processDataFinished)

    Q_PROPERTY(bool loadingState READ loadingState NOTIFY loadingStateChanged)
    Q_PROPERTY(bool downloadingState READ downloadingState NOTIFY downloadingStateChanged)

    // ...

    Q_PROPERTY(bool showConfirmed READ showConfirmed WRITE setShowConfirmed)
    Q_PROPERTY(bool showRecovered READ showRecovered WRITE setShowRecovered)
    Q_PROPERTY(bool showDeaths READ showDeaths WRITE setShowDeaths)
    Q_PROPERTY(bool showActive READ showActive WRITE setShowActive)

    // ...

    Q_PROPERTY(QString xMin READ xMin NOTIFY xMinChanged)
    Q_PROPERTY(QString xMax READ xMax NOTIFY xMaxChanged)
    Q_PROPERTY(int yMax READ yMax NOTIFY yMaxChanged)
    Q_PROPERTY(int yTickInterval READ yTickInterval NOTIFY yMaxChanged)

    // ..
    Q_PROPERTY(QStringList yLabels READ yLabels NOTIFY yLabelsChanged)
    Q_PROPERTY(QStringList xLabels READ xLabels NOTIFY xLabelsChanged)

    // Selectors

    Q_PROPERTY(Country country READ country WRITE setCountry NOTIFY countryChanged)
    Q_PROPERTY(Cases cases READ cases WRITE setCases NOTIFY casesChanged)
    Q_PROPERTY(TimePeriod timePeriod READ timePeriod WRITE setTimePeriod NOTIFY timePeriodChanged)
    Q_PROPERTY(Scale scale READ scale WRITE setScale NOTIFY scaleChanged)

    // Datasets

    Q_PROPERTY(QStringList dateList READ dateList NOTIFY dateListChanged)
    Q_PROPERTY(QVariantList confirmedArray READ confirmedArray NOTIFY confirmedArrayChanged)
    Q_PROPERTY(QVariantList recoveredArray READ recoveredArray NOTIFY recoveredArrayChanged)
    Q_PROPERTY(QVariantList activeArray READ activeArray NOTIFY activeArrayChanged)
    Q_PROPERTY(QVariantList deathsArray READ deathsArray NOTIFY deathsArrayChanged)



public:
    explicit DataHandler(QObject *parent = nullptr);

    // Enums

    enum Country {AustriaCountry, BelarusCountry, BelgiumCountry, DenmarkCountry, FinlandCountry, FranceCountry,
                  GermanyCountry, IndiaCountry, ItalyCountry, JapanCountry, NetherlandsCountry, NorwayCountry, PolandCountry, PortugalCountry,
                  RussiaCountry, SpainCountry, SwedenCountry, SwitzerlandCountry, UkraineCountry, UnitedKingdomCountry, USCountry,
                  UnknownCountry};
    Q_ENUM(Country)

    enum Cases {TotalCases, DailyNewCases};
    Q_ENUM(Cases)

    enum TimePeriod {TwoWeeksTimePeriod, ThreeWeeksTimePeriod, OneMonthTimePeriod, TwoMonthsTimePeriod};
    Q_ENUM(TimePeriod)

    enum Scale {LinearScale, LogarithmicScale};
    Q_ENUM(Scale)

    // ...

    void connectSignals() const;

    bool dataProcessed() const;
    void setDataProcessed();

    // ...
    bool loadingState() const;
    bool downloadingState() const;

    // ...
    bool showConfirmed() const;
    void setShowConfirmed(bool showConfirmed);

    bool showRecovered() const;
    void setShowRecovered(bool showRecovered);

    bool showDeaths() const;
    void setShowDeaths(bool showDeaths);

    bool showActive() const;
    void setShowActive(bool showActive);

    // ...

    int yMax() const;
    void updateYMax();

    void setXMinMap();

    QString xMin() const;
    void updateXMin();

    QString xMax() const;
    void updateXMax();

    // ...

    const QStringList &xLabels() const;
    void updateXLabels();

    int yTickInterval() const;
    const QStringList &yLabels() const;
    void updateYLabels();

    // Selectors

    Country country() const;
    void setCountry(const Country index);

    Cases cases() const;
    void setCases(const Cases index);

    TimePeriod timePeriod() const;
    void setTimePeriod(const TimePeriod index);

    Scale scale() const;
    void setScale(const Scale index);

    Q_INVOKABLE void detectClientCountryStarted();
    void onDetectClientCountryFinished(QNetworkReply *reply);
    void setClientCountry(const QByteArray &rawContent);

    // Datasets

    const QStringList &dateList() const;
    void updateDateList();

    const QVariantList &confirmedArray() const;
    void updateConfirmedArray();

    const QVariantList &recoveredArray() const;
    void updateRecoveredArray();

    const QVariantList &activeArray() const;
    void updateActiveArray();

    const QVariantList &deathsArray() const;
    void updateDeathsArray();

    // Files

    Q_INVOKABLE void loadDataFromLocalResourcesStarted();
    void loadTotal();
    void loadRecovered();
    void loadDeaths();

    Q_INVOKABLE void downloadDataFromWebStarted();
    void downloadTotalStarted();
    void downloadRecoveredStarted();
    void downloadDeathsStarted();
    void onDownloadTotalFinished(QNetworkReply *reply);
    void onDownloadRecoveredFinished(QNetworkReply *reply);
    void onDownloadDeathsFinished(QNetworkReply *reply);

    void preprocessTotal(const QByteArray &rawContent);
    void preprocessRecovered(const QByteArray &rawContent);
    void preprocessDeaths(const QByteArray &rawContent);

    void processData();
    void processDate();
    void processTotal();
    void processRecovered();
    void processActive();
    void processDeaths();


public slots:

    void onCountryChanged();
    void onCasesChanged();
    void onTimePeriodChanged();
    void onScaleChanged();

    void onShowConfirmedChanged();
    void onShowRecoveredChanged();
    void onShowActiveChanged();
    void onShowDeathsChanged();


Q_SIGNALS:

    void loadingStateChanged();
    void downloadingStateChanged();

    // ...

    void showConfirmedChanged();
    void showRecoveredChanged();
    void showActiveChanged();
    void showDeathsChanged();

    // ...

    void xMinChanged();
    void xMaxChanged();
    void yMaxChanged();
    void yTickIntervalChanged();

    // ...

    void yLabelsChanged();
    void xLabelsChanged();

    // ...

    void dataUrlChanged();

    // Selectors

    void countryChanged();
    void casesChanged();
    void timePeriodChanged();
    void scaleChanged();

    // Datasets

    void dateListChanged();
    void confirmedArrayChanged();
    void recoveredArrayChanged();
    void activeArrayChanged();
    void deathsArrayChanged();

    // ..

    void totalPreprocessed();
    void recoveredPreprocessed();
    void deathsPreprocessed();

    // ..

    void processDataFinished();

private:

    bool m_dataProcessed = false;
    bool m_downloadingState = false;
    bool m_loadingState = true;


    // ...
    bool m_showConfirmed = true;
    bool m_showRecovered = true;
    bool m_showDeaths = true;
    bool m_showActive = true;

    // ...

    bool m_totalReceived = false;
    bool m_recoveredReceived = false;
    bool m_deathsReceived = false;

    // ...

    int m_yMin = 0;
    int m_yMax = 1;
    int m_yTickInterval = 1000000;

    QMap<TimePeriod, QString> m_xMinMap{
        { TwoWeeksTimePeriod, QString() },
        { ThreeWeeksTimePeriod, QString() },
        { OneMonthTimePeriod, QString() },
        { TwoMonthsTimePeriod, QString() }
    };
    QString m_xMin;
    QString m_xMax;

    // ...

    QStringList m_xLabels;
    QStringList m_yLabels;

    // Time series data

    const QString m_baseUrl = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/";
    const QString m_totalUrl = m_baseUrl + "time_series_covid19_confirmed_global.csv";
    const QString m_recoveredUrl = m_baseUrl + "time_series_covid19_recovered_global.csv";
    const QString m_deathsUrl = m_baseUrl + "time_series_covid19_deaths_global.csv";

    const QString m_totalPath = ":/data/time_series_covid19_confirmed_global.csv";
    const QString m_recoveredPath = ":/data/time_series_covid19_recovered_global.csv";
    const QString m_deathsPath = ":/data/time_series_covid19_deaths_global.csv";

    // Selectors

    Country m_country = USCountry;
    Cases m_cases = TotalCases;
    TimePeriod m_timePeriod = OneMonthTimePeriod;
    Scale m_scale = LinearScale;

    const QMap<Country, QString> m_countryMap{
        { AustriaCountry, "Austria" },
        { BelarusCountry, "Belarus" },
        { BelgiumCountry, "Belgium" },
        { DenmarkCountry, "Denmark" },
        { FinlandCountry, "Finland" },
        { FranceCountry, "France" },
        { GermanyCountry, "Germany" },
        { IndiaCountry, "India" },
        { ItalyCountry, "Italy" },
        { JapanCountry, "Japan" },
        { NetherlandsCountry, "Netherlands" },
        { NorwayCountry, "Norway" },
        { PolandCountry, "Poland" },
        { PortugalCountry,"Portugal" },
        { RussiaCountry, "Russia" },
        { SpainCountry, "Spain" },
        { SwedenCountry, "Sweden" },
        { SwitzerlandCountry, "Switzerland" },
        { UkraineCountry, "Ukraine" },
        { UnitedKingdomCountry, "United Kingdom" },
        { USCountry, "US" },
        { UnknownCountry, "" },
    };

    const QMap<TimePeriod, int> m_timePeriodMap{
        { TwoWeeksTimePeriod, 13 },
        { ThreeWeeksTimePeriod, 22 },
        { OneMonthTimePeriod, 31 },
        { TwoMonthsTimePeriod, 61 }
    };




    // Datasets

    QStringList m_dateList;
    QVariantList m_confirmedArray;
    QVariantList m_recoveredArray;
    QVariantList m_deathsArray;
    QVariantList m_activeArray;

    QMap<Country, QVector<int>> m_confirmedMap;
    QMap<Country, QVector<int>> m_recoveredMap;
    QMap<Country, QVector<int>> m_deathsMap;
    QMap<Country, QVector<int>> m_activeMap;

    // Files

    QStringList m_totalRows;
    QStringList m_recoveredRows;
    QStringList m_deathsRows;

    QString m_totalHeaders;
    QString m_recoveredHeaders;
    QString m_deathsHeaders;

    // Download managers
    QNetworkAccessManager m_totalDownloadManager;
    QNetworkAccessManager m_recoveredDownloadManager;
    QNetworkAccessManager m_deathsDownloadManager;
    QNetworkAccessManager m_clientCountryManager;

};

#endif // DATAHANDLER_H


//https://doc.qt.io/qt-5/qtqml-cppintegration-data.html#sequence-type-to-javascript-array
//https://doc.qt.io/qt-5/qtqml-referenceexamples-properties-example.html
//https://wiki.qt.io/Download_Data_from_URL/ru
//https://wiki.qt.io/Download_Data_from_URL


//https://stackoverflow.com/questions/26393207/qt-downloading-file-with-qnetworkaccessmanager
//https://stackoverflow.com/questions/44908256/qt-download-data-from-url



//https://forum.qt.io/topic/94898/get-json-value-from-api-response
//https://stackoverflow.com/questions/51092115/read-json-from-https-in-qt
//https://forum.qt.io/topic/96491/load-json-file


//https://forum.qt.io/topic/96491/load-json-file
//https://stackoverflow.com/questions/19822211/qt-parsing-json-using-qjsondocument-qjsonobject-qjsonarray
//https://stackoverflow.com/questions/15893040/how-to-create-read-write-json-files-in-qt5
//https://stackoverflow.com/questions/42600462/qt-parsing-contents-of-csv-file-and-storing-into-array-of-structures
//https://stackoverflow.com/questions/27318631/parsing-through-a-csv-file-in-qt


//QVector<int> vector;
//vector.resize(3);
//QRandomGenerator generator;
//generator.fillRange(vector.data(), vector.size());
//QVariantList::fromVector(vector);
//QVariantList variantList = QVariantList::fromVector(vector2);
//m_recoveredArray = QVariantList::fromVector(vector2);//new QVariant(vector.toList());
// https://cpp.hotexamples.com/ru/examples/-/QVariantList/-/cpp-qvariantlist-class-examples.html
// in QML: Array.from(dataHandler.recoveredVector)
