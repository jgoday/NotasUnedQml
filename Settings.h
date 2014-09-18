#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>
#include <QCoreApplication>

#include "SimpleCrypt.h"

class Settings : public QSettings
{
    Q_OBJECT
    public:
        Settings(QObject *parent = 0);

        Q_INVOKABLE void setSecretValue(const QString &key, const QString &value);
        Q_INVOKABLE QString secretValue(const QString &key, const QString &defaultValue = QString(""));

        Q_INVOKABLE void setValue(const QString &key, const QVariant &value);
        Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;

    private:
        SimpleCrypt mCrypt;
    };
#endif // SETTINGS_H
