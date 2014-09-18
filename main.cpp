#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

#include "Settings.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setWindowIcon(QIcon(QString("qrc:///resources/icon.png")));

    QQmlApplicationEngine engine;
    Settings settings(&engine);

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("settings", &settings);

    engine.load(QUrl(QStringLiteral("qrc:///qml/main.qml")));

    return app.exec();
}
