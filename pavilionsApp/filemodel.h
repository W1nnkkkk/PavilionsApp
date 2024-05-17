#ifndef FILEMODEL_H
#define FILEMODEL_H

#include <QAbstractListModel>
#include <QFileSystemWatcher>
#include <QDir>
#include <QFileInfoList>

class FileModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit FileModel(QObject *parent = nullptr);

    enum FileRoles {
        NameRole = Qt::UserRole + 1,
        PathRole,
        IsDirRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void setDirectory(const QString &path);

private slots:
    void directoryChanged(const QString &path);
    void fileChanged(const QString &path);

private:
    QDir directory;
    QFileSystemWatcher fileWatcher;
    QFileInfoList fileList;

    void updateFileList();
};

#endif // FILEMODEL_H
