import QtQuick 2.12
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: page2
    width: parent.width
    height: parent.height

    Rectangle {
        color: backgroundColor // Цвет фона
        width: parent.width
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        clip: true // Обрезать содержимое за пределами Rectangle

        ListView {
            id: pavilionBase
            model: PavilionModel
            width: parent.width
            height: parent.height
            anchors.fill: parent
            spacing: 10
            delegate: PavilionsDelegate {
                width: parent.width

                scName: model.sc_name + " - " + model.sc_status
                pavilionNum: "Номер павильона: " + model.pavilion_num
                pavStatus:"Статус павильона: " + model.pav_status
                floor: "Этаж: " + model.floor
                scValueAddedCoof: "Коофицент добавочной стоимости: " + model.value_added_coof
                square: "Плошадь: " + model.square
                costPerSquare : "Стоимость за кв.м: " + model.cost_per_square

                Button {
                    id: rentButton
                    anchors {
                        right: parent.right
                        rightMargin: 40
                        verticalCenter: parent.verticalCenter
                    }
                    icon.source: "qrc:/Images/images/Icons/rentIcon.png"
                    icon.height: 140
                    onClicked: {
                        rentDialog.visible = true;
                    }
                }


                RentDialog {
                    id: rentDialog
                    visible: false
                }
            }
        }

        Popup {
            id: popup
            width: 150
            height: 50
            x: (parent.width - width) / 2
            y: parent.height - height - 20

            contentItem: Item {
                width: parent.width
                height: parent.height
                Rectangle {
                    id: mainItem
                    color: "white"
                    radius: Math.min(width, height) / 2
                    width: parent.width
                    height: parent.height
                    Text {
                        id: popupText
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            Timer {
                id: popupTimer
                interval: 2500
                onTriggered: popup.close()
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 700
                }
            }
        }
    }
}



