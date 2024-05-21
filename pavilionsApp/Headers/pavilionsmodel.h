#ifndef PAVILIONSMODEL_H
#define PAVILIONSMODEL_H

#include "abstrucquerytmodel.h"

class PavilionsModel : public AbstrucQuerytModel
{
public:
    PavilionsModel(QObject* parent = nullptr);

    enum CustomRoles {
        NameRole = Qt::UserRole + 1,
        PavilionNumRole,
        FloorRole,
        PavilionStatusRole,
        SquareRole,
        CostPerSquareRole,
        ValueAddedCoofRole,
        CityRole,
        SCStatusRole
    };

    // QAbstractItemModel interface
public:
    QHash<int, QByteArray> roleNames() const;
};

#endif // PAVILIONSMODEL_H
