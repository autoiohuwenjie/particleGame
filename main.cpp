#include <QGuiApplication>
#include <QQuickView>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    view.setSource(QUrl("qrc:/main.qml"));
    //view.setSource(QUrl("qrc:/BallShoting.qml"));
    QObject::connect((QObject*)view.engine(),SIGNAL(quit()), &app, SLOT(quit()));//需要强转回Qbject
    view.setMaximumSize(QSize(640,540));
    view.setMinimumSize(QSize(640,540));
    //view.show();
    QQuickView ballView;
    ballView.setMaximumSize(QSize(1024,768));
    ballView.setMinimumSize(QSize(1024,768));
    ballView.setSource(QUrl("qrc:/BallShoting.qml"));
    //ballView.setSource(QUrl("qrc:/common/BallShaderEffect.qml"));
    ballView.setPosition(400,150);
    ballView.show();
    return app.exec();
}
