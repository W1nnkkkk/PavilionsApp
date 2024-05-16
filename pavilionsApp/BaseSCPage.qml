import QtQuick 2.12
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.12

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

    RowLayout {
        id: findLayout
        anchors {
            top: cityBox.bottom
            left: parent.left
            right: parent.right
            bottomMargin: 10
        }
        Rectangle {
            id: findRect
            height: findButton.height - 10
            Layout.fillWidth: true
            radius: 6
            color: "white"
            TextField {
                id: findTextArea
                height: findButton.height
                placeholderText: "Поиск"
                anchors {
                    fill: parent
                    leftMargin: 5
                    rightMargin: 5
                }

                leftPadding: 0
                rightPadding: 0
                topPadding: 0
                bottomPadding: 0
            }
        }
        Button {
            id: findButton
            icon.source: "qrc:/Images/images/Icons/findIcon.png"

            onClicked: {
                if (cityBox.currentText === "Все")
                {
                    var binds = [":name"];
                    var values = [findTextArea.text];

                    SCModel.setModelQuery("SELECT * FROM sc WHERE name LIKE '%' || :name || '%'
                                            AND sc_status != 'Удален'
                                            ORDER BY name, sc_status", binds, values);
                }
                else {
                    var bindss = [":name", ":city"];
                    var valuess = [findTextArea.text, cityBox.currentText];

                    SCModel.setModelQuery("SELECT * FROM sc WHERE name LIKE '%' || :name || '%'
                                            AND sc_status != 'Удален' AND city = :city
                                            ORDER BY name, sc_status", bindss, valuess);
                }

            }
        }
    }
    Rectangle {
        color: backgroundColor // Цвет фона
        width: parent.width
        anchors {
            top: findLayout.bottom
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

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        PavilionModel.setModelQuery("SELECT pavilions.*, sc.city FROM pavilions
                                                     JOIN sc ON pavilions.sc_name = sc.name
                                                     WHERE sc.name = '" + model.name + "' AND pav_status = 'Свободен';")
                        pagePush(mainView, page2);
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
            }
        }
    }

    Component.onCompleted: {
        cityBox.currentIndex = 0;
    }
}
