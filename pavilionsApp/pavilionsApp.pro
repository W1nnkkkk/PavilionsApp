QT += quick core sql

CONFIG += c++17

LIBS += -lzip
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        abstrucquerytmodel.cpp \
        citymodel.cpp \
        databasedescriptor.cpp \
        filemodel.cpp \
        fileopener.cpp \
        main.cpp \
        odfcreator.cpp \
        pavilionsmodel.cpp \
        scmodel.cpp

RESOURCES += qml.qrc \
    pics.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    abstrucquerytmodel.h \
    citymodel.h \
    databasedescriptor.h \
    filemodel.h \
    fileopener.h \
    odfcreator.h \
    pavilionsmodel.h \
    scmodel.h

