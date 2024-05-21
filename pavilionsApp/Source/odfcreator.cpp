#include "odfcreator.h"
#include <QCoreApplication>
#include <QProcess>
#include <iostream>

OdfCreator::OdfCreator()
{

}

void OdfCreator::createOdfByPath(const QString &filePath, const QString &tenantNumber, const QString &mallName, const QString &employeeNumber, const QString &pavilionNumber, const QString &dateEnd)
{
    QString program = "python3";
    QString script = "create_contract.py";

    QStringList arguments;
    arguments << script << filePath << tenantNumber << mallName << employeeNumber << pavilionNumber << dateEnd;

    QProcess process;
    process.start(program, arguments);
    process.waitForFinished();

    QString output(process.readAllStandardOutput());
    QString error(process.readAllStandardError());

    if (!error.isEmpty()) {
        std::cerr << "Error: " << error.toStdString() << std::endl;
    } else {
        std::cout << "Output: " << output.toStdString() << std::endl;
    }
}
