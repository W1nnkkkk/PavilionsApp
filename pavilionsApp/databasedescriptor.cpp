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
    static QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL"); // Замените на вашу используемую базу данных
    db.setDatabaseName("pavilions"); // Замените на имя вашей базы данных
    db.setHostName("127.0.0.1"); // Замените на имя вашего хоста
    db.setUserName("postgres"); // Замените на имя вашего пользователя базы данных
    db.setPassword("2407"); // Замените на пароль вашего пользователя базы данных

    if (!db.open()) {
       qDebug() << db.lastError().text();
    }

    return db;
}
