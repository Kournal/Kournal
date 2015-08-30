#include "SettingsHandler.hpp"

#include "config-dev.hpp"

#include <QMessageBox>

SettingsHandler::SettingsHandler(QObject *parent, bool load) : QObject(parent)
{
    if (load)
    {
        loadConfig();
    }
}

void SettingsHandler::loadConfig()
{
    mutex.lock();
    mutex.unlock();
}

void SettingsHandler::saveConfig()
{
    mutex.lock();
    mutex.unlock();
}

bool SettingsHandler::isModified()
{
    return modified;
}

QString& SettingsHandler::getUsername()
{
    return general_userinfo_name;
}

void SettingsHandler::setUsername(const QString& username)
{
    modified = true;
    mutex.lock();
    general_userinfo_name = username;
    QMessageBox::information(0, "Username", username);
    mutex.unlock();
}
