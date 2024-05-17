#include "abstrucquerytmodel.h"
#include "databasedescriptor.h"
#include "odfcreator.h"
#include <thread>
#include <QJSValueIterator>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

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

bool AbstrucQuerytModel::setCustomQuery(const QString &query, const QJSValue &binds, const QJSValue &values, int docNum)
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

    std::thread th([&]() {
       OdfCreator::createOdfByPath("./RentContract/ДоговорАренды" + valuesVector[3].toString() + ".odt",
                                   valuesVector[0].toString(),
                                   valuesVector[1].toString(),
                                   valuesVector[2].toString(),
                                   valuesVector[3].toString(),
                                   valuesVector[6].toString());
    });

    QSqlQuery req(DataBaseDescriptor::getDB());
    req.prepare(query);


    for (int i = 0; i < bindsVector.size(); i++)
    {
        req.bindValue(bindsVector[i], valuesVector[i]);
    }

    th.join();

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
