#ifndef DATABASEDESCRIPTOR_H
#define DATABASEDESCRIPTOR_H

#include <QSqlDatabase>

class DataBaseDescriptor
{
public:
    DataBaseDescriptor();
    static QSqlDatabase& getDB();

private:
    static QSqlDatabase& init();
};

#endif // DATABASEDESCRIPTOR_H
