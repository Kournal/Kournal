/*
 * WelcomeWidget.hpp – welcome screen widget
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

#include "WelcomeWidget.hpp"

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:

    void on_fileTabs_tabCloseRequested(int index);

    void on_actionOpenJournal_triggered();

private:
    Ui::MainWindow *ui;

    WelcomeWidget *welcome;
};
