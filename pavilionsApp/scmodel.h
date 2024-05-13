#ifndef SCMODEL_H
#define SCMODEL_H

#include "abstrucquerytmodel.h"

class SCModel : public AbstrucQuerytModel
{
public:
    SCModel(QObject* parent = nullptr);

    enum CustomRoles {
        NameRole = Qt::UserRole + 1,
        StatusRole,
        PavilionsCountRole,
        CityRole,
        CostRole,
        ValueAddedRole,
        FloorCountRole,
        PhotoRole
    };

    // QAbstractItemModel interface
public:
    QHash<int, QByteArray> roleNames() const;
};

#endif // SCMODEL_H
