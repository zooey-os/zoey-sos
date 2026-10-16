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

            // Quick Fixes Card
            Kirigami.Card {
                Layout.fillWidth: true
                header: Kirigami.Heading {
                    text: "1-Click Quick Fixes"
                    level: 2
                    color: "#f4b8e4"
                }
                contentItem: ColumnLayout {
                    spacing: 12

                    Text {
                        text: fixWorker.statusMessage
                        font.pixelSize: 14
                        color: "#ca9ee6"
                        wrapMode: Text.WorkWrap
                        Layout.fillWidth: true
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        QQC2.Button {
                            Layout.fillWidth: true
                            text: "Fix Audio"
                            enabled: !fixWorker.isBusy
                            onClicked: fixWorker.fixAudio()
                        }

                        QQC2.Button {
                            Layout.fillWidth: true
                            text: "Fix Internet"
                            enabled: !fixWorker.isBusy
                            onClicked: fixWorker.fixNetwork()
                        }

                        QQC2.Button {
                            Layout.fillWidth: true
                            text: "Refresh Desktop"
                            enabled: !fixWorker.isBusy
                            onClicked: fixWorker.fixDesktopShell()
                        }
                    }
                }
            }
        }
    }
}
