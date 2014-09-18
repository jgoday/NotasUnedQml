#include "Settings.h"

Settings::Settings(QObject *parent) :
    QSettings("com.notasUned", "notasUned", parent),
    mCrypt(1929845726)
{
}

void Settings::setSecretValue(const QString &key, const QString &value)
{
    QSettings::setValue(key, mCrypt.encryptToString(value));
}

QString Settings::secretValue(const QString &key, const QString &defaultValue)
{
    const QString s = QSettings::value(key, defaultValue).toString();
    return mCrypt.decryptToString(s);
}

void Settings::setValue(const QString &key, const QVariant &value)
{
    QSettings::setValue(key, value);
}

QVariant Settings::value(const QString &key, const QVariant &defaultValue) const
{
    return QSettings::value(key, defaultValue);
}
