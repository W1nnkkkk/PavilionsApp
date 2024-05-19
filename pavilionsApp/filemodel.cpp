#include "filemodel.h"
#include <QDebug>

FileModel::FileModel(QObject *parent)
    : QAbstractListModel(parent)
{
    connect(&fileWatcher, &QFileSystemWatcher::directoryChanged,
            this, &FileModel::directoryChanged);
    connect(&fileWatcher, &QFileSystemWatcher::fileChanged,
            this, &FileModel::fileChanged);
}

int FileModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return fileList.size();
}

QVariant FileModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= fileList.size())
        return QVariant();

    const QFileInfo &fileInfo = fileList.at(index.row());
    switch (role) {
    case NameRole:
        return fileInfo.fileName();
    case PathRole:
        return fileInfo.absoluteFilePath();
    case IsDirRole:
        return fileInfo.isDir();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> FileModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[PathRole] = "path";
    roles[IsDirRole] = "isDir";
    return roles;
}

void FileModel::setDirectory(const QString &path)
{
    beginResetModel();
    directory.setPath(path);
    updateFileList();
    fileWatcher.addPath(path);
    endResetModel();
}

void FileModel::directoryChanged(const QString &path)
{
    Q_UNUSED(path);
    updateFileList();
}

void FileModel::fileChanged(const QString &path)
{
    Q_UNUSED(path);
    updateFileList();
}

void FileModel::updateFileList()
{
    beginResetModel();

    fileList = directory.entryInfoList(QDir::NoDotAndDotDot | QDir::AllEntries);
    QStringList currentPaths = fileWatcher.files();

    if (!currentPaths.isEmpty()) {
        fileWatcher.removePaths(currentPaths);
    }

    for (const QFileInfo &fileInfo : fileList) {
        if (fileInfo.isFile()) {
            fileWatcher.addPath(fileInfo.absoluteFilePath());
        }
    }

    endResetModel();
    //emit dataChanged(createIndex(0, 0), createIndex(fileList.size() - 1, 0));
}
