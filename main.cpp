#include <QGuiApplication>
#include <QUrl>
#include <QString>
#include <QQuickView>
#include <QQmlEngine>
#include <QNetworkAccessManager>
#include <QDebug>
#include <QSettings>
#include <QNetworkCookieJar>
#include <QNetworkCookie>
#include <QtWebEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QtWebEngine::initialize();
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    
    QGuiApplication *app = new QGuiApplication(argc, (char**)argv);
    app->setApplicationName("home.s710");

    QQuickView *view = new QQuickView();
    view->setSource(QUrl("qrc:/Main.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->show();

    return app->exec();
}
