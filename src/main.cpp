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
 * Project website: https://github.com/Kournal/Kournal
 * License:         GPLv2 or later
 */

#include "ui/KournalWindow.hpp"
#include "Static.hpp"
#include "config.hpp"

#include <QApplication>

#include <KF5/KCoreAddons/KAboutData>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    KAboutData aboutData(QStringLiteral(PROJECT_NAME),
                         QStringLiteral(PROJECT_STRING),
                         QStringLiteral(PROJECT_VERSION),
                         QStringLiteral("TODO desc"),
                         KAboutLicense::GPL_V2,
                         QStringLiteral("Copyright (C) 2015 Kournal team"), QString(),
                         QStringLiteral(PROJECT_URL),
                         QStringLiteral("marek@pikula.co"));

    aboutData.addAuthor(QStringLiteral("Marek Pikuła"), QStringLiteral("App developement"),
                        QStringLiteral("marek@pikula.co"));

    KAboutData::setApplicationData(aboutData);
    
    KournalWindow w;
    Static::setParent(&w);
    w.show();

    return a.exec();
}
