import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Web 0.2
import com.canonical.Oxide 1.9 as Oxide

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "webview-oxide.liu-xiao-guo"

    property string usContext: "messaging://"

    width: units.gu(60)
    height: units.gu(85)

    Page {
        title: i18n.tr("webview-oxide")

        Rectangle {
            anchors.fill: parent

            // Both the UserScript and the call to sendMessage need to share the same
            // context, which should be in the form of a URL.  It doesn't seem to matter
            // what it is, though.
            property string usContext: "messaging://"

            WebView {
                id: webview
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: button.top
                }
                context: webcontext
                url: {
                    console.log("address: " + Qt.resolvedUrl("index.html"))
                    return Qt.resolvedUrl("index.html")
                }
            }

            WebContext {
                id: webcontext
                userScripts: [
                    Oxide.UserScript {
                        context: usContext
                        url: Qt.resolvedUrl("oxide-user.js")
                    }
                ]
            }

            Button {
                id: button
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
                text: "Press Me"
                onClicked: {
                    var req = webview.rootFrame.sendMessage(usContext, "MESSAGE", {greeting: "Hello"})
                    req.onreply = function (msg) {
                        console.log("Got reply: " + msg.str);
                    }
                    req.onerror = function (code, explanation) {
                        console.log("Error " + code + ": " + explanation)
                    }
                }
            }
        }
    }
}

