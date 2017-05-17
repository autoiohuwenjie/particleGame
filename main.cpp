#include <QGuiApplication>
#include <QQuickView>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QQuickView view;
    view.setSource(QUrl("qrc:/main.qml"));
    //view.setSource(QUrl("qrc:/ClickEffect.qml"));
    QObject::connect((QObject*)view.engine(),SIGNAL(quit()), &app, SLOT(quit()));//需要强转回Qbject
    view.setMaximumSize(QSize(640,540));
    view.setMinimumSize(QSize(640,540));
    view.show();
    return app.exec();
}
