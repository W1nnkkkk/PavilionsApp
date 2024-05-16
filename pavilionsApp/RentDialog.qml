import QtQuick 2.2
import QtQml 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Dialog {
    id: rentDialog
    standardButtons: StandardButton.No | StandardButton.Yes

    title: " "

    ColumnLayout {
        spacing: 10
        Text {
            text: "Вы хотите арендовать павильон номер '" + model.pavilion_num + "' на месяц?"
        }
        TextField {
            id: tenatIdField
            Layout.fillWidth: true
            validator: IntValidator { bottom: 1; top: 999 }
            placeholderText: "Номер арендатора"

            onTextChanged: {
                placeholderTextColor = "grey";
            }
        }
        TextField {
            id: employeeIdField
            Layout.fillWidth: true
            validator: IntValidator { bottom: 1; top: 999 }
            placeholderText: "Номер сотрудника"

            onTextChanged: {
                placeholderTextColor = "grey";
            }
        }
    }

    onYes: {
        var tenatId = tenatIdField.text;
        var employeeId = employeeIdField.text;

        if (tenatId === "" || employeeId === "")
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
            var binds = [":idTen",":scName", ":idEmp",":pavNum", ":pavStat", ":pavRentStat"];
            var values = [Number(tenatId) ,scName, Number(employeeId), pavNum, pavState, rentPavState];
            var req = "SELECT pavilions_rent_wrapper(:idTen, :scName, :idEmp, :pavNum, :pavStat, :pavRentStat)";

            if (PavilionModel.setCustomQuery(req, binds, values))
            {
                PavilionModel.setModelQuery("SELECT pv.*, sc.sc_status FROM public.pavilions pv JOIN sc ON pv.sc_name = sc.name
                                 WHERE sc.sc_status != 'Удален' AND pav_status = 'Свободен'");

                popupText.text = "Павилион арендован";
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
