import QtQuick 2.12
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    id: page1
    width: parent.width
    height: parent.height

    property alias cityBoxes : cityBox

    ComboBox {
        id: cityBox
        model: CityModel
        height: 50
        width: parent.width

        onCurrentTextChanged: {
            filterSC(currentText);
        }
    }
    Rectangle {
        color: backgroundColor // Цвет фона
        width: parent.width
        anchors {
            top: cityBox.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        clip: true // Обрезать содержимое за пределами Rectangle

        ListView {
            id: baseSC
            model: SCModel
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
                    icon.source: "qrc:/Images/images/Icons/trashIcon.png"
                    icon.color: "red"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    onClicked: {
                        messageDialog.visible = true;
                    }
                    MessageDialog {
                        id: messageDialog
                        property var updateFunction: updateDeletedSC
                        title: "Вы уверенны?"
                        text: "Вы уверенны что хотите изменить статус '" + model.name + "' на удален?"
                        standardButtons: StandardButton.Yes | StandardButton.No
                        icon: StandardIcon.Question
                        onYes: {
                            var binds = [":name", ":city"];
                            var values = [model.name, model.city];
                            SCModel.setCustomQuery("UPDATE sc SET sc_status = 'Удален' WHERE name = :name AND city = :city",
                                                   binds, values);
                            filterSC(cityBox.currentText);
                            updateFunction();
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        cityBox.currentIndex = 0;
    }
}
