TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    SimpleCrypt.cpp \
    Settings.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \
    README.md

HEADERS += \
    Settings.h \
    SimpleCrypt.h

RC_ICONS = resources/icon.ico
