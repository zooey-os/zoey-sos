#pragma once

#include <QObject>
#include <QString>

class FixWorker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusChanged)
    Q_PROPERTY(bool isBusy READ isBusy NOTIFY busyChanged)

public:
    explicit FixWorker(QObject *parent = nullptr);

    QString statusMessage() const;
    bool isBusy() const;

    Q_INVOKABLE void fixAudio();
    Q_INVOKABLE void fixNetwork();
    Q_INVOKABLE void fixDesktopShell();

signals:
    void statusChanged();
    void busyChanged();

private:
    QString m_statusMessage{"Select a quick fix below if something feels off"};
    bool m_isBusy{false};

    void runCommand(const QString &label, const QString &cmd);
};
