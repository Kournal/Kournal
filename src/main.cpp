/*
 * main.cpp – main() method file
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
 * Creation date:   26.08.2015
 * Project website: https://kournal.github.io/
 * License:         GPLv2 or later
 */

#include "ui/KournalWindow.hpp"
#include "Static.hpp"
#include "config.hpp"
#include "config-i18n.hpp"

#include <QApplication>
#include <QLocale>
#include <QLibraryInfo>
#include <QTranslator>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    
    // Translations
    QTranslator qtTranslator;
    qtTranslator.load(QStringLiteral("qt_") + QLocale::system().name(),
                      QLibraryInfo::location(QLibraryInfo::TranslationsPath));
    a.installTranslator(&qtTranslator);

    QTranslator kournalTranslator;
    kournalTranslator.load(QLocale::system().name(),
                           QStringLiteral(TR_SEARCH_PATH));
    a.installTranslator(&kournalTranslator);
    
    // Application info
    a.setApplicationName(QStringLiteral(PROJECT_NAME_UC));
    a.setApplicationDisplayName(QStringLiteral(PROJECT_NAME_UC));
    a.setApplicationVersion(QStringLiteral(PROJECT_VERSION));
    a.setOrganizationName(QStringLiteral(PROJECT_NAME_UC));
    a.setOrganizationDomain(QStringLiteral(PROJECT_URL));

    KournalWindow w;
    Static::setParent(&w);
    w.show();

    return a.exec();
}
