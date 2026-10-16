#include "FixWorker.hpp"
#include <QProcess>

FixWorker::FixWorker(QObject *parent) : QObject(parent) {}

void FixWorker::runCommand(const QString &label, const QString &cmd)
{
    if (m_isBusy)
        return;

    m_isBusy = true;
    m_statusMessage = "Running: " + label + "...";
    emit busyChanged();
    emit statusChanged();

    auto *proc = new QProcess(this);
    connect(proc, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
            this, [this, proc, label](int exitCode, QProcess::ExitStatus)
            {
                m_isBusy = false;
                if (exitCode == 0)
                {
                    m_statusMessage = label + " completed! Everything should be fresh now";
                }
                else
                {
                    m_statusMessage = label + " finished (code " + QString::number(exitCode) + ").";
                }
                emit busyChanged();
                emit statusChanged();
                proc->deleteLater(); });

    proc->start("/bin/sh", QStringList() << "-c" << cmd);
}

void FixWorker::fixAudio()
{
    runCommand("Audio Reset (Pipewire)", "systemctl --user restart pipewire wireplumber");
}

void FixWorker::fixNetwork()
{
    runCommand("Network Reset", "nmcli networking off && sleep 1 && nmcli networking on");
}

void FixWorker::fixDesktopShell()
{
    runCommand("Desktop Dock & UI Refresh", "kquitapp6 plasmashell && kstart plasmashell");
}

QString FixWorker::statusMessage() const { return m_statusMessage; }
bool FixWorker::isBusy() const { return m_isBusy; }
