#ifndef ABSTRUCQUERYTMODEL_H
#define ABSTRUCQUERYTMODEL_H

#include <QSqlQueryModel>
#include <QJSValue>
#include <QObject>

class AbstrucQuerytModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    AbstrucQuerytModel(QObject* parent = nullptr);
    Q_INVOKABLE void setModelQuery(const QString& query);
    Q_INVOKABLE void setCustomQuery(const QString& query, const QJSValue &binds, const QJSValue &values);

    // QAbstractItemModel interface
public:
    QVariant data(const QModelIndex &index, int role) const;
};

#endif // ABSTRUCQUERYTMODEL_H
