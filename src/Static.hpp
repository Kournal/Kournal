/*
 * Static.hpp – static Kournal definitions class
 *
 * Copyright (C) 2015  Kournal team
 * This file is part of Kournal.
 *
 * Kournal is free software: you can redistribute it and/or modify  it under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later version.
 *
 * Foobar is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with Kournal.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * File author:     Marek Pikuła
 * Creation date:   26.08.2015
 * Project website: https://github.com/Kournal/Kournal
 * License:         GPLv2 or later
 */

#pragma once

#include "model/settings/SettingsHandler.hpp"
#include "ui/KournalWindow.hpp"

class Static
{
public:
    static void setParent(KournalWindow *parent);

    static SettingsHandler *getSettings();
    static void setSettings(SettingsHandler *settings);

protected:
    static SettingsHandler *settings;

    // We're sure it's set by main
    static KournalWindow *parent;

};
