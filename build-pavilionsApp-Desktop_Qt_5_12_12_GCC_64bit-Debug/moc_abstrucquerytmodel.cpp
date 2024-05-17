/****************************************************************************
** Meta object code from reading C++ file 'abstrucquerytmodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.12)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../pavilionsApp/abstrucquerytmodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'abstrucquerytmodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.12. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_AbstrucQuerytModel_t {
    QByteArrayData data[9];
    char stringdata0[86];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_AbstrucQuerytModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_AbstrucQuerytModel_t qt_meta_stringdata_AbstrucQuerytModel = {
    {
QT_MOC_LITERAL(0, 0, 18), // "AbstrucQuerytModel"
QT_MOC_LITERAL(1, 19, 13), // "setModelQuery"
QT_MOC_LITERAL(2, 33, 0), // ""
QT_MOC_LITERAL(3, 34, 5), // "query"
QT_MOC_LITERAL(4, 40, 8), // "QJSValue"
QT_MOC_LITERAL(5, 49, 5), // "binds"
QT_MOC_LITERAL(6, 55, 6), // "values"
QT_MOC_LITERAL(7, 62, 14), // "setCustomQuery"
QT_MOC_LITERAL(8, 77, 8) // "haveFile"

    },
    "AbstrucQuerytModel\0setModelQuery\0\0"
    "query\0QJSValue\0binds\0values\0setCustomQuery\0"
    "haveFile"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_AbstrucQuerytModel[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    1,   34,    2, 0x02 /* Public */,
       1,    3,   37,    2, 0x02 /* Public */,
       7,    3,   44,    2, 0x02 /* Public */,
       7,    4,   51,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString, 0x80000000 | 4, 0x80000000 | 4,    3,    5,    6,
    QMetaType::Bool, QMetaType::QString, 0x80000000 | 4, 0x80000000 | 4,    3,    5,    6,
    QMetaType::Bool, QMetaType::QString, 0x80000000 | 4, 0x80000000 | 4, QMetaType::Int,    3,    5,    6,    8,

       0        // eod
};

void AbstrucQuerytModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<AbstrucQuerytModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->setModelQuery((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->setModelQuery((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QJSValue(*)>(_a[2])),(*reinterpret_cast< const QJSValue(*)>(_a[3]))); break;
        case 2: { bool _r = _t->setCustomQuery((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QJSValue(*)>(_a[2])),(*reinterpret_cast< const QJSValue(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->setCustomQuery((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QJSValue(*)>(_a[2])),(*reinterpret_cast< const QJSValue(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 2:
            case 1:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        case 2:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 2:
            case 1:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        case 3:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 2:
            case 1:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject AbstrucQuerytModel::staticMetaObject = { {
    &QSqlQueryModel::staticMetaObject,
    qt_meta_stringdata_AbstrucQuerytModel.data,
    qt_meta_data_AbstrucQuerytModel,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *AbstrucQuerytModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *AbstrucQuerytModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_AbstrucQuerytModel.stringdata0))
        return static_cast<void*>(this);
    return QSqlQueryModel::qt_metacast(_clname);
}

int AbstrucQuerytModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QSqlQueryModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
