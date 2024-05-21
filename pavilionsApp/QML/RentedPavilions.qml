import QtQuick 2.2
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    id: page5

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
            id: rentedPavilions
            model: RentedPavilionModel
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
                    id: openForRentButton
                    anchors {
                        right: parent.right
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                    icon.source: "qrc:/Images/images/Icons/refreshIcon.png"
                    icon.color: "green"

                    onClicked: {
                        updateDialog.visible = true;
                    }
                }

                MessageDialog {
                    id: updateDialog
                    visible: false
                    title: "Вы уверенны?"
                    text: "Вы уверенны что хотите снять статус аренды с '" + model.sc_name + " " + model.pavilion_num + "'?"
                    standardButtons: StandardButton.Yes | StandardButton.No
                    icon: StandardIcon.Question
                    onYes: {
                        var binds = [":pavNum", ":scName"];
                        var values = [model.pavilion_num, model.sc_name];
                        RentedPavilionModel.setCustomQuery("UPDATE pavilions SET pav_status = 'Свободен'
                                                            WHERE pavilion_num = :pavNum
                                                            AND sc_name = :scName", binds, values);
                        console.log("do");
                        RentedPavilionModel.setModelQuery("SELECT pv.*, sc.sc_status FROM public.pavilions pv JOIN sc ON pv.sc_name = sc.name
                                 WHERE sc.sc_status != 'Удален' AND pav_status != 'Свободен' AND pav_status != 'Удален'");
                    }
                }
            }
        }
    }
}
