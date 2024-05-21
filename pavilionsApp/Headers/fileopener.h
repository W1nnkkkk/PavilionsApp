#ifndef FILEOPENER_H
#define FILEOPENER_H

#include <QObject>

class FileOpener : public QObject
{
    Q_OBJECT
public:
    explicit FileOpener(QObject *parent = nullptr);
    Q_INVOKABLE void openFile(const QString &filePath);
};

#endif // FILEOPENER_H
