#ifndef ODFCREATOR_H
#define ODFCREATOR_H

#include <QObject>

class OdfCreator
{
public:
    OdfCreator();

    static void createOdfByPath(const QString& filePath,
                                const QString &tenantNumber,
                                const QString &mallName,
                                const QString &employeeNumber,
                                const QString &pavilionNumber,
                                const QString &dateEnd);
};

#endif // ODFCREATOR_H
