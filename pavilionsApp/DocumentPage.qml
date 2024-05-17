import QtQuick 2.2
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: page6
    visible: false

    ListView {
        anchors.fill: parent
        model: FileModel

        delegate: Rectangle {
            id: root
            color: "lightsteelblue"
            radius: 6
            height: imageFile.height + imageFile.anchors.margins * 1.5
            anchors.fill: parent

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!model.isDir) {
                        FileOpener.openFile(model.path)
                    }
                }

                onPressed: {
                    colorRect.x = mouseX
                    colorRect.y = mouseY
                    circleAnimation.start()
                }

                onReleased: {
                    circleAnimation.stop()
                }

                onPositionChanged: {
                    circleAnimation.stop()
                }
            }

            Rectangle {
                id: colorRect
                height: 0
                width: 0
                color: "#50e0e0e0"

                transform: Translate {
                    x: -colorRect.width/2
                    y: -colorRect.height/2
                }

                PropertyAnimation {
                    id: circleAnimation
                    target: colorRect
                    properties: "width, height, radius"
                    from: 0
                    to: root.height
                    duration: 300

                    onStopped: {
                        colorRect.width = 0
                        colorRect.height = 0
                    }
                }
            }

            Row {
                spacing: 10
                anchors.fill: parent
                anchors.margins: 10
                Image {
                    id: imageFile
                    source: "qrc:/Images/images/Icons/file-icon.png"
                    width: 64
                    height: imageFile.width
                    sourceSize: Qt.size(imageFile.width, imageFile.width)
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    text: model.name
                    font.bold: true
                    font.pointSize: 16
                    Layout.alignment: Qt.AlignCenter
                }
            }
        }
    }
}
