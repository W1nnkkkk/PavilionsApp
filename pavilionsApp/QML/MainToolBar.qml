import QtQuick 2.12
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ToolBar {

    RowLayout {
        anchors.fill: parent

        ToolButton {
            Layout.alignment: Qt.AlignCenter
            icon.source: "qrc:/Images/images/Icons/SCIcon.png"
            onClicked: {
                pagePush(mainView, page1);
            }
        }

        ToolButton {
            Layout.alignment: Qt.AlignCenter
            icon.source: "qrc:/Images/images/Icons/pavilionsICon.png"
            onClicked: {
                PavilionModel.setModelQuery("SELECT pv.*, sc.sc_status FROM public.pavilions pv JOIN sc ON pv.sc_name = sc.name
                                 WHERE sc.sc_status != 'Удален' AND pav_status = 'Свободен'");
                page2.visible = true;
                pagePush(mainView, page2);
            }
        }

        ToolButton {
            Layout.alignment: Qt.AlignCenter
            icon.source: "qrc:/Images/images/Icons/No_icon.png"
            onClicked: {
                page3.visible = true;
                pagePush(mainView, page3);
            }
        }

        ToolButton {
            Layout.alignment: Qt.AlignCenter
            icon.source: "qrc:/Images/images/Icons/addIcon.png"
            onClicked: {
                pagePush(mainView, page4);
            }
        }

        ToolButton {
            Layout.alignment: Qt.AlignCenter
            icon.source: "qrc:/Images/images/Icons/noRentIcon.png"
            onClicked: {
                RentedPavilionModel.setModelQuery("SELECT pv.*, sc.sc_status FROM public.pavilions pv JOIN sc ON pv.sc_name = sc.name
                                 WHERE sc.sc_status != 'Удален' AND pav_status != 'Свободен' AND pav_status != 'Удален'
                                 ORDER BY pv.sc_name");
                pagePush(mainView, page5);
            }
        }

        ToolButton {
            Layout.alignment: Qt.AlignCenter
            icon.source: "qrc:/Images/images/Icons/documentIcon.png"
            onClicked: {
                pagePush(mainView, page6);
            }
        }
    }
}
