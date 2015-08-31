/*
 * SettingsHandler – handler of Kournal settings
 *
 * Copyright (C) 2015  Kournal team
 * This file is part of Kournal.
 *
 * Kournal is free software: you can redistribute it and/or modify  it under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later version.
 *
 * Kournal is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with Kournal.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * File author:     Marek Pikuła
 * Creation date:   27.08.2015
 * Project website: https://github.com/Kournal/Kournal
 * License:         GPLv2 or later
 */

#pragma once

#include <QMutex>
#include <QObject>
#include <QFile>
#include <QString>
#include <QSharedPointer>

#include <yaml-cpp/node/node.h>

class SettingsHandler : public QObject
{
    Q_OBJECT

public:
    explicit SettingsHandler(QObject* parent = 0, bool load = true);

    void loadSettings();
    void saveSettings();
    void emitDefaultSettings();

    bool isModified();

    QString& getUsername();
    void setUsername(const QString& username);

private:
    QMutex mutex;
    bool modified = false;

    QSharedPointer<QFile> settingsFile;
    QSharedPointer<YAML::Node> settingsNode;

    QString general_userinfo_name;

};
