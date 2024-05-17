import QtQuick 2.2
import QtQml 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import Qt.labs.calendar 1.0

Dialog {
    id: rentDialog
    standardButtons: StandardButton.No | StandardButton.Yes
    title: " "

    ColumnLayout {
        id: coll
        spacing: 10
        width: parent.width

        Text {
            text: "Вы хотите арендовать павильон номер '" + model.pavilion_num + "'?"
        }

        TextField {
            id: tenatIdField
            Layout.fillWidth: true
            placeholderText: "Название фирмы арендатора"

            onTextChanged: {
                placeholderTextColor = "grey"
            }
        }

        TextField {
            id: employeeIdField
            Layout.fillWidth: true
            placeholderText: "Логин сотрудника"

            onTextChanged: {
                placeholderTextColor = "grey"
            }
        }

        ListView {
            id: listview
            property var selectedDate: new Date()

            Layout.fillWidth: true
            Layout.preferredHeight: 300
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal
            highlightRangeMode: ListView.StrictlyEnforceRange
            spacing: 10

            Component.onCompleted: {
                var futureDate = new Date();
                futureDate.setFullYear(futureDate.getFullYear() + 1); // Отображаем год вперед
                model.from = new Date();
                model.to = futureDate;
            }

            model: CalendarModel { }

            delegate: Item {
                width: listview.width
                height: listview.height

                Column {
                    spacing: 10
                    width: parent.width
                    height: parent.height

                    Text {
                        id: text
                        text: Qt.formatDate(new Date(model.year, model.month, 1), "MMMM yyyy") // Отображаем месяц и год
                        font.bold: true
                        font.pointSize: 14
                        horizontalAlignment: Text.AlignHCenter
                    }

                    MonthGrid {
                        id: monthGrid
                        width: parent.width
                        height: parent.height - text.height - spacing
                        month: model.month
                        year: model.year
                        locale: Qt.locale("en_US")

                        delegate: Rectangle {
                            width: 40
                            height: 40
                            border.color: "black"
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: day
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (day !== 0) {
                                        var selectedMonth = model.month;
                                        var selectedYear = model.year;

                                        if (day < 15 && index >= 28) {
                                            selectedMonth--;
                                            if (selectedMonth < 0) {
                                                selectedMonth = 11;
                                                selectedYear--;
                                            }
                                        } else if (day > 15 && index < 7) {
                                            selectedMonth++;
                                            if (selectedMonth > 11) {
                                                selectedMonth = 0;
                                                selectedYear++;
                                            }
                                        }

                                        listview.selectedDate = new Date(selectedYear, selectedMonth, day);
                                        console.log("Selected Date:", listview.selectedDate);
                                    }
                                }
                            }

                            Rectangle {
                                opacity: listview.selectedDate.getFullYear() === monthGrid.year && listview.selectedDate.getMonth() === monthGrid.month && listview.selectedDate.getDate() === model.day ? 0.3 : 0
                                anchors.fill: parent
                                color: "lightblue"
                            }
                        }
                    }
                }
            }

            ScrollIndicator.horizontal: ScrollIndicator { }
        }
    }

    onYes: {
        var tenatId = tenatIdField.text;
        var employeeId = employeeIdField.text;
        var dateE = listview.selectedDate;
        popupText.text = "Павилион арендован";

        if (tenatId === "" || employeeId === "" || dateE === undefined)
        {
            console.log("Не выполнено!");
            popupText.text = "Что-то пошло не так";
            popup.open();
            popup.opacity = 0;
            popup.open();

            popupTimer.restart();
        }
        else {
            var scName = model.sc_name;
            var pavNum = model.pavilion_num;
            var pavState = "Арендован";
            var rentPavState = "Ожидание";
            var binds = [":idTen",":scName", ":idEmp",":pavNum", ":pavStat", ":pavRentStat", ":dateE"];
            var values = [tenatId ,scName, employeeId, pavNum, pavState, rentPavState, dateE];
            var req = "SELECT pavilions_rent_wrapper(:idTen, :scName, :idEmp, :pavNum, :pavStat, :pavRentStat, :dateE)";

            if (PavilionModel.setCustomQuery(req, binds, values, 1))
            {
                PavilionModel.setModelQuery("SELECT pv.*, sc.sc_status FROM public.pavilions pv JOIN sc ON pv.sc_name = sc.name
                                 WHERE sc.sc_status != 'Удален' AND pav_status = 'Свободен'");
            }
            else {
                popupText.text = "Что-то пошло не так";
            }

            popup.open();
            popup.opacity = 0;
            popup.open();

            popupTimer.restart();
        }

        tenatIdField.text = "";
        employeeIdField.text = "";
    }
}
