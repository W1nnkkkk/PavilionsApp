import QtQuick 2.12
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    property alias scName: scName.text
    property alias pavStatus: pavStatus.text
    property alias scValueAddedCoof :valueAddedCoof.text
    property alias floor: floor.text
    property alias pavilionNum : pavNum.text
    property alias square : square.text
    property alias costPerSquare : costPerSquare.text
    height: mainView.height / 2.5

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: 6
        color: "lightsteelblue"
        clip: true

        ColumnLayout {
            id: coll
            anchors.fill: parent
            anchors.margins: 6
            Text {
                id: scName
                font.bold: true
            }
            Text {
                id: pavNum
            }
            Text {
                id: floor
            }
            Text {
                id: pavStatus
            }
            Text {
                id: square
            }
            Text {
                id: costPerSquare
            }
            Text {
                id: valueAddedCoof
            }
        }
    }
}
