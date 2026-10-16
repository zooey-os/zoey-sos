import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.applicationWindow {
    id: root
    title: "Zoey SOS - Self-Heal & Support"
    width: 680
    height: 540
    minimumWidth: 580
    minimumHeight: 460

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Need a hand, Zoey?"

        ColumnLayout {
            spacing: 20
            width: parent.width

            Kirigami.Card {
                Layout.fillWidth: true
                header: Kirigami.Heading {
                    text: "Emergency Companion"
                    level: 2
                    color: "#f4b8e4"
                }
                contentItem: Text {
                    text: "If audio, Wi-Fi, or your desktop dock ever acts up, use the quick fixes here or send a diagnostic snapshot to Sho."
                    font.pixelSize: 14
                    color: "#c6d0f5"
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}
