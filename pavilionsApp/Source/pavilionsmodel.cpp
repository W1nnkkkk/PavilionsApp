#include "pavilionsmodel.h"

PavilionsModel::PavilionsModel(QObject* parent) : AbstrucQuerytModel(parent)
{

}

QHash<int, QByteArray> PavilionsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "sc_name";
    roles[PavilionNumRole] = "pavilion_num";
    roles[FloorRole] = "floor";
    roles[PavilionStatusRole] = "pav_status";
    roles[SquareRole] = "square";
    roles[CostPerSquareRole] = "cost_per_square";
    roles[ValueAddedCoofRole] = "value_added_coof";
    roles[CityRole] = "city";
    roles[SCStatusRole] = "sc_status";
    return roles;
}
