import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Zoey SOS — Self-Heal & Support ♥"
    width: 680
    height: 540
    minimumWidth: 580
    minimumHeight: 460

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: "Need a hand, Zoey? 🌸"

        ColumnLayout {
            spacing: 20
            width: parent.width

            // Quick Fixes Card
            Kirigami.Card {
                Layout.fillWidth: true
                header: Kirigami.Heading {
                    text: "1-Click Quick Fixes 🛠️"
                    level: 2
                    color: "#f4b8e4"
                }
                contentItem: ColumnLayout {
                    spacing: 12

                    Text {
                        text: fixWorker.statusMessage
                        font.pixelSize: 14
                        color: "#ca9ee6"
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        QQC2.Button {
                            Layout.fillWidth: true
                            text: "Fix Audio 🔊"
                            enabled: !fixWorker.isBusy
                            onClicked: fixWorker.fixAudio()
                        }

                        QQC2.Button {
                            Layout.fillWidth: true
                            text: "Fix Internet 🌐"
                            enabled: !fixWorker.isBusy
                            onClicked: fixWorker.fixNetwork()
                        }

                        QQC2.Button {
                            Layout.fillWidth: true
                            text: "Refresh Desktop ✨"
                            enabled: !fixWorker.isBusy
                            onClicked: fixWorker.fixDesktopShell()
                        }
                    }
                }
            }

            // Diagnostic Report for Sho Card
            Kirigami.Card {
                Layout.fillWidth: true
                header: Kirigami.Heading {
                    text: "Message Sho — Diagnostic Snapshot 💌"
                    level: 2
                    color: "#a6d189"
                }
                contentItem: ColumnLayout {
                    spacing: 10

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 130
                        radius: 6
                        color: "#232634"
                        border.color: "#838ba7"
                        border.width: 1

                        Text {
                            anchors.fill: parent
                            anchors.margins: 10
                            text: diagReport.summaryText
                            font.family: "monospace"
                            font.pixelSize: 12
                            color: "#c6d0f5"
                            wrapMode: Text.WordWrap
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        QQC2.Button {
                            text: "Copy Report for Sho 📋"
                            onClicked: diagReport.copyToClipboard()
                        }

                        QQC2.Button {
                            text: "Refresh Stats 🔄"
                            onClicked: diagReport.generateReport()
                        }

                        Text {
                            text: diagReport.copyFeedback
                            font.pixelSize: 13
                            color: "#f2d5cf"
                            Layout.fillWidth: true
                        }
                    }
                }
            }

            // System Time Machine (Btrfs Rollback) Card
            Kirigami.Card {
                Layout.fillWidth: true
                header: Kirigami.Heading {
                    text: "System Time Machine ⏪"
                    level: 2
                    color: "#8caaee"
                }
                contentItem: ColumnLayout {
                    spacing: 10

                    Text {
                        text: snapshotMgr.statusText
                        font.pixelSize: 13
                        color: "#c6d0f5"
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }

                    Repeater {
                        model: snapshotMgr.snapshots
                        delegate: Rectangle {
                            Layout.fillWidth: true
                            height: 44
                            radius: 6
                            color: "#292c3c"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 12
                                anchors.rightMargin: 12

                                Text {
                                    text: "#" + modelData.id + " — " + modelData.date + " (" + modelData.description + ")"
                                    color: "#f2d5cf"
                                    font.pixelSize: 13
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                QQC2.Button {
                                    text: "Rewind Here ⏪"
                                    onClicked: snapshotMgr.rollbackTo(modelData.id)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
