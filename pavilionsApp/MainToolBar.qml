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
    }
}
