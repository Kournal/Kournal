#include "SettingsHandler.hpp"

#include "config-dev.hpp"

#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QMessageBox>
#include <QString>
#include <QStandardPaths>

#include <yaml-cpp/yaml.h>

#include <fstream>
#include <string>

#define S (*settingsNode)

// YAML type convertion overloads

YAML::Emitter& operator << (YAML::Emitter& out, const QString& v) {
    out << v.toStdString();
    return out;
}

namespace YAML {
template<>
struct convert<QString>
{
    static Node encode(const QString& rhs)
    {
        return Node(rhs.toStdString());
    }

    static bool decode(const Node& node, QString& rhs)
    {
        if(!node.IsScalar())
        {
            return false;
        }
        rhs = QString::fromStdString(node.Scalar());
        return true;
    }
};
}

// TODO: handle YAML exceptions

SettingsHandler::SettingsHandler(QObject *parent, bool load) : QObject(parent)
{
    settingsFile = QSharedPointer<QFile>::create(QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation)
                                                 + QStringLiteral("/settings.yaml"));
    if (load)
    {
        loadSettings();
    }
}

void SettingsHandler::loadSettings()
{
    mutex.lock();

    QFileInfo settingsFileInfo(*settingsFile);
    if (!settingsFileInfo.exists())
    {
        emitDefaultSettings();
    }

    if (settingsNode.isNull())
    {
        settingsNode.reset();
    }
    settingsNode = QSharedPointer<YAML::Node>::create(YAML::LoadFile(settingsFileInfo.absoluteFilePath().toStdString()));

    general_userinfo_name = S["general"]["userInfo"]["userName"].as<QString>();

    mutex.unlock();
}

void SettingsHandler::saveSettings()
{
    mutex.lock();

    YAML::Emitter out;
    out << S;

    settingsFile->open(QFile::WriteOnly | QFile::Text);
    settingsFile->write(out.c_str(), out.size());
    settingsFile->close();

    mutex.unlock();
}

void SettingsHandler::emitDefaultSettings()
{
    QFileInfo settingsFileInfo(settingsFile->fileName());
    settingsFileInfo.absoluteDir().mkpath(QStringLiteral("."));

    YAML::Emitter out;
    out.SetIndent(4);
    out.SetMapFormat(YAML::Flow);

    out << YAML::BeginMap
            << YAML::Key << "general"
            << YAML::Value << YAML::BeginMap
                << YAML::Key << "userInfo"
                << YAML::Value << YAML::BeginMap
                    << YAML::Key << "userName"
                    << YAML::Value << tr("User", "Default user name in settings")
                << YAML::EndMap
            << YAML::EndMap
        << YAML::EndMap;

    settingsFile->open(QFile::WriteOnly | QFile::Text);
    settingsFile->write(out.c_str(), out.size());
    settingsFile->close();
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
    S["general"]["userInfo"]["userName"] = username;
    mutex.unlock();
}
