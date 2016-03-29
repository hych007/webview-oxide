TEMPLATE = app
TARGET = webview-oxide

load(ubuntu-click)

QT += qml quick

SOURCES += main.cpp

RESOURCES += webview-oxide.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true) \
             $$files(*.html,true)

CONF_FILES +=  webview-oxide.apparmor \
               webview-oxide.png

AP_TEST_FILES += tests/autopilot/run \
                 $$files(tests/*.py,true)

#show all the files in QtCreator
OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
               webview-oxide.desktop

#specify where the config files are installed to
config_files.path = /webview-oxide
config_files.files += $${CONF_FILES}
INSTALLS+=config_files

#install the desktop file, a translated version is 
#automatically created in the build directory
desktop_file.path = /webview-oxide
desktop_file.files = $$OUT_PWD/webview-oxide.desktop
desktop_file.CONFIG += no_check_exist
INSTALLS+=desktop_file

# specify where the qml/js files are installed to
# we need to add this part
qml_files.path = /qtquick
qml_files.files += $${QML_FILES}

# Default rules for deployment.
target.path = $${UBUNTU_CLICK_BINARY_PATH}
INSTALLS+=target qml_files

