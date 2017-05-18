#include <QGuiApplication>
#include <QtQuick>



int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    view.setSource(QUrl("qrc:/main.qml"));
    view.setPosition(500,150);
    QObject *object = view.rootObject();
    QObject *quitButton = object->findChild<QObject*>("ballButton");

    QObject::connect((QObject*)view.engine(),SIGNAL(quit()), &app, SLOT(quit()));//需要强转回Qbject
    view.setMaximumSize(QSize(640,540));
    view.setMinimumSize(QSize(640,540));
    view.show();
    QQuickView ballView;
    ballView.setMaximumSize(QSize(1024,768));
    ballView.setMinimumSize(QSize(1024,768));
    ballView.setSource(QUrl("qrc:/BallShoting.qml"));
    ballView.setPosition(400,150);
    if (quitButton)
    {
        QObject::connect(quitButton, SIGNAL(clicked()), &view, SLOT(hide()));
        QObject::connect(quitButton, SIGNAL(clicked()), &ballView, SLOT(show()));
    }

    QObject *ballObject = ballView.rootObject();
    QObject *returnMenuButton = ballObject ->findChild<QObject*>("returnButton");
    if (returnMenuButton){
       QObject::connect(returnMenuButton, SIGNAL(clicked()), &ballView, SLOT(close()));
       QObject::connect(returnMenuButton, SIGNAL(clicked()), &view, SLOT(show()));
    }
    return app.exec();
}
