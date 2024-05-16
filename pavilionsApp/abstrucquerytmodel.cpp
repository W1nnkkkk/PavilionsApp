#include "abstrucquerytmodel.h"
#include "databasedescriptor.h"
#include <QJSValueIterator>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>
#include <QResource>
#include <QDirIterator>

AbstrucQuerytModel::AbstrucQuerytModel(QObject* parent) : QSqlQueryModel(parent)
{

}

void AbstrucQuerytModel::setModelQuery(const QString &query)
{
    setQuery(query, DataBaseDescriptor::getDB());

    if (lastError().isValid()) {
        qDebug() << "Error setting query:" << lastError().text();
    }
    else {
        qDebug() << "Sucess!: " << rowCount();
    }
}

void AbstrucQuerytModel::setModelQuery(const QString &query, const QJSValue &binds, const QJSValue &values)
{
    QVector<QString> bindsVector;
    QVector<QVariant> valuesVector;

    if (binds.isArray()) {
        QJSValueIterator it(binds);
        while (it.hasNext()) {
            it.next();
            QString bind = it.value().toString();
            bindsVector.append(bind);
        }
    }

    if (values.isArray()) {
        QJSValueIterator it(values);
        while (it.hasNext()) {
            it.next();
            QVariant value = it.value().toVariant();
            valuesVector.append(value);
        }
    }

    QSqlQuery req(DataBaseDescriptor::getDB());
    req.prepare(query);


    for (int i = 0; i < bindsVector.size(); i++)
    {
        req.bindValue(bindsVector[i], valuesVector[i]);
    }


    req.exec();
    setQuery(req);

    if (lastError().isValid()) {
        qDebug() << "Error setting query:" << lastError().text();
    }
    else {
        qDebug() << req.lastQuery();
        qDebug() << "Sucess! : " << rowCount();
    }
}

bool AbstrucQuerytModel::setCustomQuery(const QString &query, const QJSValue &binds, const QJSValue &values)
{
    QVector<QString> bindsVector;
    QVector<QVariant> valuesVector;

    if (binds.isArray()) {
        QJSValueIterator it(binds);
        while (it.hasNext()) {
            it.next();
            QString bind = it.value().toString();
            bindsVector.append(bind);
        }
    }

    if (values.isArray()) {
        QJSValueIterator it(values);
        while (it.hasNext()) {
            it.next();
            QVariant value = it.value().toVariant();
            valuesVector.append(value);
        }
    }

    QSqlQuery req(DataBaseDescriptor::getDB());
    req.prepare(query);


    for (int i = 0; i < bindsVector.size(); i++)
    {
        req.bindValue(bindsVector[i], valuesVector[i]);
    }

    if (!req.exec()) {
        qDebug() << req.lastError().text();
        return false;
    }

    return true;
}

QVariant AbstrucQuerytModel::data(const QModelIndex &index, int role) const
{
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}
