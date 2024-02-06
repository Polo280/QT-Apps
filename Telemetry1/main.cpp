#include <QApplication>
#include <QQmlApplicationEngine>
#include "Libraries/serialhandler.h"

static QObject *serialHandlerSingletonProvider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return new SerialHandler();
}


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterSingletonType<SerialHandler>("SerialHandler", 1, 0, "SerialHandler", serialHandlerSingletonProvider);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/Telemetry1/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
