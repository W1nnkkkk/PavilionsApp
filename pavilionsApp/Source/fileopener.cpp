#include "fileopener.h"
#include <QProcess>
#include <QDebug>

FileOpener::FileOpener(QObject *parent) : QObject(parent)
{
}

void FileOpener::openFile(const QString &filePath)
{
    QProcess process;
    QString program = "libreoffice"; // Path to LibreOffice executable if not in PATH
    QStringList arguments;
    arguments << filePath;
    if (!process.startDetached(program, arguments)) {
        qWarning() << "Failed to start LibreOffice for file:" << filePath;
    }
}
