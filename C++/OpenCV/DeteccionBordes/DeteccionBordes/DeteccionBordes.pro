TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp

LIBS += `pkg-config opencv --libs`

include(deployment.pri)
qtcAddDeployment()

