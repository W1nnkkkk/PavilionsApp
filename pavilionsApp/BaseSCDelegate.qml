import QtQuick 2.12
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {

    property alias scphoto: photo.source
    property alias scname: name.text
    property alias scstatus: status.text
    property alias scfloorcount: scFloorCount.text
    property alias sccost : cost.text
    property alias scvalueaddedcoof :valueAddedCoof.text
    height: photo.height + photo.anchors.margins * 2

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: "lightsteelblue"
        clip: true

        Image {
            id: photo
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 6
            width: 128
            height: photo.width
            sourceSize: Qt.size(photo.width, photo.width)
            fillMode: Image.PreserveAspectFit
        }

        ColumnLayout {
            anchors {
                left: photo.right
                top: parent.top
                bottom: parent.bottom
                margins: 10
            }

            Text {
                id: name
                font.bold: true
            }
            Text {
                id: status
            }
            Text {
                id: scFloorCount
            }
            Text {
                id: cost
            }
            Text {
                id: valueAddedCoof
            }
        }
    }
}
