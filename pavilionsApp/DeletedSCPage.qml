import QtQuick 2.12
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    id: page3
    property alias mainModel: deletedSC.model

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
            id: deletedSC
            model: DeletedSCModel
            width: parent.width
            height: parent.height
            anchors.fill: parent
            spacing: 10
            delegate: BaseSCDelegate {
                id: root
                width: parent.width

                scphoto: model.photo
                scname: model.name + ' - ' + model.city
                scstatus: "Статус: " + model.sc_status
                scfloorcount: "Кол-во этажей: " + model.floor_count
                sccost : "Стоимость постройки: " + model.cost + " руб."
                scvalueaddedcoof : "Коофицент добавочной стоимости: " + model.value_added_coof

                Button {
                    icon.source: "qrc:/Images/images/Icons/refreshIcon.png"
                    icon.color: "green"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    onClicked: {
                        messageDialog.visible = true;
                    }
                }
                MessageDialog {
                    id: messageDialog
                    title: "Вы уверенны?"
                    text: "Вы уверенны что хотите востановить '" + model.name + "' со случайным статусом?"
                    standardButtons: StandardButton.Yes | StandardButton.No
                    icon: StandardIcon.Question
                    onYes: {
                        var statuses = ["План", "Строительство", "Реализация"];
                        var binds = [":name", ":status", ":city"];
                        var values = [model.name, statuses[getRandomInt(3)], model.city];
                        SCModel.setCustomQuery("UPDATE sc SET sc_status = :status WHERE name = :name AND city = :city",
                                               binds, values);
                        filterSC(page1.cityBoxes.currentText);
                        updateDeletedSC();
                    }
                }
            }
        }
    }
}
