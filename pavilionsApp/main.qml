import QtQuick 2.2
import QtQml 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Pavilions App")


    property string backgroundColor: "steelblue"

    color: backgroundColor

    header: MainToolBar {
    }

    StackView {
        id: mainView
        initialItem: page1
        anchors.fill: parent
        anchors.margins: 10
    }

    BaseSCPage {
        id: page1
    }

    PavilionsPage {
        id: page2
        visible: false
    }

    DeletedSCPage {
        id: page3
    }

    RentedPavilions {
        id: page5
        visible: false
    }

    AddPage {
        id: page4
        visible: false
    }

    function pagePush(view, page) {
        if (!view.push(page))
            view.pop(page);
    }

    function filterSC(cityName) {
        if (cityName !== "Все")
            SCModel.setModelQuery("SELECT * FROM sc WHERE sc_status != 'Удален' AND city = '"
                                    + cityName + "' ORDER BY name, sc_status");
        else
            SCModel.setModelQuery("SELECT * FROM sc WHERE sc_status != 'Удален' ORDER BY name, sc_status");
    }

    function updateDeletedSC() {
        DeletedSCModel.setModelQuery("SELECT * FROM sc WHERE sc_status = 'Удален' ORDER BY name, sc_status");
    }

    function getRandomInt(max) {
        return Math.floor(Math.random() * max);
    }
}
