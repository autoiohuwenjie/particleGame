#include <QGuiApplication>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QQuickView view;

    //view.setSource(QUrl("qrc:/vertexAndFragment.qml"));

    //view.setSource(QUrl("qrc:/vertTexShader.qml"));
    view.setSource(QUrl("qrc:/FireShader.qml"));
    //view.setSource(QUrl("qrc:/sunRotation.qml"));


    //view.setSource(QUrl("qrc:/fireFog.qml"));

    //view.setSource(QUrl("qrc:/ringCut.qml")); //无波动的
    //view.setSource(QUrl("qrc:/ringCutRight.qml"));//有波动的

    //view.setSource(QUrl("qrc:/smoker.qml"));
    //view.setSource(QUrl("qrc:/waveEffect.qml"));
    //view.setSource(QUrl("qrc:/Trapezium.qml"));
    view.show();

    return app.exec();
}
