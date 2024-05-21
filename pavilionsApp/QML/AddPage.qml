import QtQuick 2.2
import QtQml 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    id: page4
    color: "lightsteelblue"
    radius: 10 // Радиус закругления углов
    clip: true

    Item {
        id: globalData
        property string path: ""
    }

    ScrollView {
        id: scroll
        anchors.fill: parent
        contentWidth: scroll.width - 20

        ColumnLayout {
            anchors {
                fill: parent
                leftMargin: 10
                topMargin: 10
                bottomMargin: 10
            }
            spacing: 10

            // Название ТЦ
            TextField {
                id: nameTextField
                placeholderText: "Название ТЦ"
                Layout.fillWidth: true
                selectByMouse: true

                onTextChanged: {
                    placeholderTextColor = "gray"
                }
            }

            // Город
            TextField {
                id: cityTextField
                placeholderText: "Город"
                Layout.fillWidth: true
                selectByMouse: true

                onTextChanged: {
                    placeholderTextColor = "gray"
                }
            }

            // Стоимость
            TextField {
                id: costTextField
                placeholderText: "Стоимость"
                validator: IntValidator { bottom: 0; top: 9999999 }
                Layout.fillWidth: true
                selectByMouse: true

                onTextChanged: {
                    placeholderTextColor = "gray"
                }
            }

            ColumnLayout {
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        id: coefText
                        text: "Коофицент добавочной стоимости:"
                    }
                    Item {
                        id: widthItem
                        width: coefText.width - countPavBox.width
                    }
                    SpinBox {
                        id: coefficientSpinBox
                        from: 01
                        value: 01
                        to: 10 * 10
                        stepSize: 01
                        Layout.fillWidth: true

                        property int decimals: 2
                        property real realValue: value / 10

                        validator: DoubleValidator {
                            bottom: Math.min(coefficientSpinBox.from, coefficientSpinBox.to)
                            top:  Math.max(coefficientSpinBox.from, coefficientSpinBox.to)
                        }

                        textFromValue: function(value, locale) {
                            return Number(value / 10).toLocaleString(locale, 'f', coefficientSpinBox.decimals)
                        }

                        valueFromText: function(text, locale) {
                            return Number.fromLocaleString(locale, text) * 10
                        }
                    }
                }

                // Количество павильонов
                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true
                    Text {
                        id: countText
                        text: "Количество павильонов:"
                        Layout.fillWidth: true
                    }
                    Item {
                        width: widthItem.width - 10
                    }
                    SpinBox {
                        id: countPavBox
                        from: 0
                        to: 50
                        stepSize: 1
                        editable: true
                        Layout.fillWidth: true
                        value: 0
                    }
                }

                // Количество этажей
                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true
                    Text {
                        id: countFloorText
                        text: "Количество этажей:"
                    }
                    Item {
                        width: (countFloorText.width - countPavBox.width) + 5
                    }
                    SpinBox {
                        id: countFloorsBox
                        from: 1
                        to: 20
                        stepSize: 1
                        editable: true
                        Layout.fillWidth: true
                        value: 1
                    }
                }
            }

            // Статусы ТЦ (радио-кнопки)
            RowLayout {
                RadioButton {
                    id: planRadioButton
                    text: "План"
                    checked: true
                }
                RadioButton {
                    id: constructionRadioButton
                    text: "Строительство"
                }
                RadioButton {
                    id: realizationRadioButton
                    text: "Реализация"
                }
            }

            Rectangle {
                id: fropRect
                Layout.fillWidth: true
                height: 100
                radius: 10
                border.color: "black"
                border.width: 1
                color: dropArea.isEntered ? "grey" : "lightgrey"

                Behavior on color {
                    ColorAnimation {
                        id: colorAnimation
                        duration: 250 // Длительность анимации в миллисекундах
                    }
                }

                DropArea {
                    id: dropArea
                    anchors.fill: parent
                    property string dropText: "Перетащите файл c фото сюда"
                    property bool isEntered: false
                    property color textColor: drop.color

                    onEntered: {
                        // Пользователь навел файл на DropArea
                        isEntered = true;
                        // Запуск анимации изменения цвета
                        colorAnimation.start()
                    }
                    onExited: {
                        // Пользователь убрал файл из DropArea
                        isEntered = false;
                        // Запуск анимации изменения цвета
                        colorAnimation.start()
                    }
                    onDropped: {
                        globalData.path = drop.text // Получаем путь к файлу
                        console.log(globalData.path)
                        dropArea.textColor = "black";
                        dropArea.dropText = "Фото успешно загружено!"
                        dropArea.enabled = false;
                        isEntered = false;
                        colorAnimation.start();
                        deleteButton.visible = true;
                    }

                    Text {
                        id: drop
                        anchors.centerIn: parent
                        text: dropArea.dropText
                        font.bold: true
                    }
                }

                Button {
                    id: deleteButton
                    visible: false
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 2
                    icon.source: "qrc:/Images/images/Icons/deletePhotoIcon.png"
                    icon.color: "red"

                    background: Rectangle {
                        color: fropRect.color
                    }

                    onClicked: {
                        globalData.path = "";
                        dropArea.enabled = true;
                        dropArea.dropText = "Перетащите файл c фото сюда";
                        dropArea.isEntered = false;
                        colorAnimation.start();
                        visible = false;
                    }
                }
            }


            // Кнопка для отправки данных
            Button {
                text: "Создать ТЦ"
                Layout.fillWidth: true
                onClicked: {
                    var make = true;
                    var tcName = nameTextField.text;
                    var city = cityTextField.text;
                    var pavilions = countFloorsBox.value;
                    var cost = costTextField.text;
                    var coefficient = coefficientSpinBox.value;
                    var floors = countPavBox.value;
                    var status = "";

                    if (planRadioButton.checked) status = "План";
                    else if (constructionRadioButton.checked) status = "Строительство";
                    else if (realizationRadioButton.checked) status = "Реализация";

                    if (tcName === "") {
                        nameTextField.placeholderTextColor = "red";
                        make = false;
                    }

                    if (city === "") {
                        cityTextField.placeholderTextColor = "red";
                        make = false;
                    }

                    if (cost === "") {
                        costTextField.placeholderTextColor = "red";
                        make = false;
                    }

                    if (globalData.path === "" ) {
                        drop.color = "red";
                        make = false;
                    }

                    // Проверяем, выбран ли какой-то статус
                    if (!planRadioButton.checked && !constructionRadioButton.checked && !realizationRadioButton.checked) {
                        make = false;
                    }

                    if (make) {
                        var nicePath = globalData.path;
                        nicePath = nicePath.replace(/[\r\n]+/g, "");
                        console.log(nicePath);
                        var binds = [":name", ":status", ":pav_count", ":city", ":cost", ":coef", ":floors", ":photo"];
                        var values = [tcName.trim(),
                                      status, pavilions, city.trim(), cost, coefficient / 10, floors, nicePath];

                        if (SCModel.setCustomQuery("INSERT INTO public.sc(
                            name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo)
                            VALUES (:name, :status, :pav_count, :city, :cost, :coef, :floors, :photo);", binds, values))
                        {
                            CityModel.setModelQuery("SELECT 'Все' AS \"city\" UNION SELECT DISTINCT city FROM sc ORDER BY city");
                            filterSC(page1.cityBoxes.currentText);

                            popupText.text = "ТЦ Создан!";
                            nameTextField.text = "";
                            cityTextField.text = "";
                            costTextField.text = "";
                            globalData.path = "";
                            dropArea.enabled = true;
                            dropArea.dropText = "Перетащите файл c фото сюда";
                        }
                        else {
                            popupText.text = "Что-то пошло не так!";
                        }

                    }
                    else {
                        popupText.text = "Что-то пошло не так!";
                    }
                    popup.open();
                    popup.opacity = 0;
                    popup.open();

                    popupTimer.restart();
                }
            }

            Item {
                height: 10
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
