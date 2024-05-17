#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "filemodel.h"
#include "fileopener.h"
#include "scmodel.h"
#include "pavilionsmodel.h"
#include "citymodel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    //app.setWindowIcon(QIcon("qrc:/Images/images/Icons/mainIcon.png"));
    QGuiApplication::setWindowIcon(QIcon(":/Images/images/Icons/mainIcon.png"));

    SCModel* scModel = new SCModel;
    SCModel* deletedSCModel = new SCModel;
    PavilionsModel* pavilionModel = new PavilionsModel;
    PavilionsModel* rentedPavilionsModel = new PavilionsModel;
    CityModel* cityModel = new CityModel;
    FileModel* fileModel = new FileModel;
    FileOpener* opener = new FileOpener;

    scModel->setModelQuery("SELECT * FROM sc WHERE sc_status != 'Удален' ORDER BY name, sc_status");
    deletedSCModel->setModelQuery("SELECT * FROM sc WHERE sc_status = 'Удален' ORDER BY name, sc_status");
    pavilionModel->setModelQuery("SELECT pv.*, sc.sc_status FROM public.pavilions pv JOIN sc ON pv.sc_name = sc.name "
                                 "WHERE sc.sc_status != 'Удален' AND pav_status = 'Свободен'");
    rentedPavilionsModel->setModelQuery("SELECT pv.*, sc.sc_status FROM public.pavilions pv JOIN sc ON pv.sc_name = sc.name "
                                         "WHERE sc.sc_status != 'Удален' AND pav_status != 'Свободен'");
    cityModel->setModelQuery("SELECT 'Все' AS \"city\" UNION SELECT DISTINCT city FROM sc ORDER BY city");
    fileModel->setDirectory("./RentContract");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("SCModel", scModel);
    engine.rootContext()->setContextProperty("DeletedSCModel", deletedSCModel);
    engine.rootContext()->setContextProperty("PavilionModel", pavilionModel);
    engine.rootContext()->setContextProperty("RentedPavilionModel", rentedPavilionsModel);
    engine.rootContext()->setContextProperty("CityModel", cityModel);
    engine.rootContext()->setContextProperty("FileModel", fileModel);
    engine.rootContext()->setContextProperty("FileOpener", opener);

    engine.load(url);

    return app.exec();
}
