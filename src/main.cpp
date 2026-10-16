#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("Zoey SOS");
    app.setOrganizationName("ZoeyOS");

    QQmlApplicationEngine engine;

    auto *fixWorker = new FixWorker(&app);
    engine.rootContext()->setContextProperty("fixWorker", fixWorker);

    const QUrl url(QStringLiteral("qrc:/Zoey/Sos/qml/Main.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl)
        {
            if (!obj && url == objUrl) QCoreApplicattion::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}
