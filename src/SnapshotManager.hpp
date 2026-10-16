#pragma once

#include <QObject>
#include <QString>
#include <QVariant>

class SnapshotManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList snapshots READ snapshots NOTIFY snapshotsChanged)
    Q_PROPERTY(QString statusText READ statusText NOTIFY statusChanged)

public:
    explicit SnapshotManager(QObject *parent = nullptr);

    QVariantList snapshots() const;
    QString statusText() const;

    Q_INVOKABLE void refreshSnapshots();
    Q_INVOKABLE void rollbackTo(const QString &snapshotId);

signals:
    void snapshotsChanged();
    void statusChanged();

private:
    QVariantList m_snapshots;
    QString m_statusText{"Select a restore point to rewind your system if an update misbehaved"};
};
