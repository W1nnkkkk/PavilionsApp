#include "scmodel.h"

SCModel::SCModel(QObject* parent) : AbstrucQuerytModel(parent)
{

}

QHash<int, QByteArray> SCModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[StatusRole] = "sc_status";
    roles[PavilionsCountRole] = "pavilions_count";
    roles[CityRole] = "city";
    roles[CostRole] = "cost";
    roles[ValueAddedRole] = "value_added_coof";
    roles[FloorCountRole] = "floor_count";
    roles[PhotoRole] = "photo";
    return roles;
}
