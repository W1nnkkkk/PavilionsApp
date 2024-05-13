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
            }
        }
    }
}



