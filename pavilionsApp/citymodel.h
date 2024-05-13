#ifndef CITYMODEL_H
#define CITYMODEL_H

#include "abstrucquerytmodel.h"

class CityModel : public AbstrucQuerytModel
{
public:
    CityModel(QObject* parent = nullptr);

    enum CustomRoles {
        CityRole = Qt::UserRole + 1
    };

    // QAbstractItemModel interface
public:
    QHash<int, QByteArray> roleNames() const;
};

#endif // CITYMODEL_H
