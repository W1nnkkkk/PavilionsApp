#include "citymodel.h"

CityModel::CityModel(QObject* parent) : AbstrucQuerytModel(parent)
{

}

QHash<int, QByteArray> CityModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[CityRole] = "city";
    return roles;
}
