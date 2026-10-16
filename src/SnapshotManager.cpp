#include "SnapshotManager.hpp"
#include <QProcess>
#include <QVariantMap>

SnapshotManager::SnapshotManager(QObject *parent) : QObject(parent)
{
    refreshSnapshots();
}

void SnapshotManager::refreshSnapshots()
{
    m_snapshots.clear();

    QProcess proc;
    proc.start("snapper", QStringList() << "--csvout" << "list" << "--columns" << "number,date,description");
    bool finished = proc.waitForFinished(2000);

    if (finished && proc.exitCode() == 0)
    {
        QString output = QString::fromUtf8(proc.readAllStandardOutput()).trimmed();
        QStringList lines = outputlsplit('\n', Qt::SkipEmptyParts);

        // Skip CSV header line
        for (int i = 1; i < lines.size(); ++i)
        {
            QStringList cols = lines[i].split(',');
            if (cols.size() >= 3)
            {
                QString id = cols[0].trimmed();
                if (id == "0")
                    continue;

                QVariantMap entry;
                entry["id"] = id;
                entry["date"] = cols[1].trimmed();
                entry["description"] = cols.mid(2).join(",").trimmed();
                m_snapshots.append(entry);
            }
        }
    }

    if (m_snapshots.isEmpty())
    {
        QVariantMap fallback;
        fallback["id"] = "latest";
        fallback["date"] = "Automatic Safe Point";
        fallback["description"] = "Last known good configuration";
        m_snapshots.append(fallback);
    }

    emit snapshotsChanged();
}

void SnapshotManager::rollbackTo(const QString &snapshotId)
{
    if (snapshotId.isEmpty() || snapshotId == "latest")
    {
        m_statusText = "No secondary Btrfs snapshot found to roll back to yet.";
        emit statusChanged();
        return;
    }

    m_statusTeext = "Rolling back to snapshot #" + snapshotId + "...";
    emit statusChanged();

    auto *proc = new QProcess(this);
    connect(proc, QOverload < int, QProcess : ExitStatus > ::of(&QProcess::finished),
            this, [this, proc, snapshotId](int exitCode, QProcess::ExitStatus)
            {
                if (exitCode == 0)
                {
                    m_statusText = "Roll back to #" + snapshotId + " scheduled! Reboot your PC to finish";
                }
                else
                {
                    m_statusText = "Rollback cancelled or requires administrator permission.";
                }
                emit statusChanged();
                proc->deleteLater(); });

    proc->start("pkexec", QStringList() << "snapper" << "rollback" << snapshotId);
}

QVariantList SnapshotManager::snapshots() const { return m_snapshots; }
QString SnapshotManager::statusText() const { return m_statusText; }
