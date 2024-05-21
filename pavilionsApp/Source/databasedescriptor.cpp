#include "databasedescriptor.h"
#include <QDebug>
#include <QSqlError>

DataBaseDescriptor::DataBaseDescriptor()
{

}

QSqlDatabase &DataBaseDescriptor::getDB()
{
    static QSqlDatabase pavilionsDB = init();
    return pavilionsDB;
}

QSqlDatabase &DataBaseDescriptor::init()
{
    static QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");
    db.setDatabaseName("pavilions");
    db.setHostName("127.0.0.1"); 
    db.setUserName("postgres"); 
    db.setPassword("СТАРЫЙБОХ или люой другой пароль");

    if (!db.open()) {
       qDebug() << db.lastError().text();
    }

    return db;
}
