#include <QGuiApplication>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QQuickView view;
    //view.setSource(QUrl("qrc:/main.qml"));
    //view.setSource(QUrl("qrc:/vertexAndFragment.qml"));
    //view.setSource(QUrl("qrc:/waveEffect.qml"));
    //view.setSource(QUrl("qrc:/vertTexShader.qml"));
    //view.setSource(QUrl("qrc:/fireShader.qml"));
    //view.setSource(QUrl("qrc:/sunRotation.qml"));
    //view.setSource(QUrl("qrc:/fireFog.qml"));

    view.setSource(QUrl("qrc:/ringCut.qml"));
    view.show();

    return app.exec();
}
