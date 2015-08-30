/*
 * SettingsDialog.cpp – [file description]
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
 * File author:     marek
 * Creation date:   27.8.2015
 * Project website: https://github.com/Kournal/Kournal
 * License:         GPLv2 or later
 */

#include "SettingsDialog.hpp"
#include "ui_SettingsDialog.h"

#include "Static.hpp"

#include <QMessageBox>

#define S Static::getSettings()

SettingsDialog::SettingsDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::SettingsDialog)
{
    ui->setupUi(this);

    ui->usernameE->setText(S->getUsername());
}

SettingsDialog::~SettingsDialog()
{
    delete ui;
}

void SettingsDialog::saveSettings()
{
    // I could have used there some fancy queuing of changes, but for this amount of data it's not worth it
    S->setUsername(ui->usernameE->text());
}

void SettingsDialog::on_buttons_clicked(QAbstractButton *button)
{
    switch (ui->buttons->buttonRole(button))
    {
    case QDialogButtonBox::AcceptRole:
        saveSettings();
        close();
        break;

    case QDialogButtonBox::ApplyRole:
        saveSettings();
        break;

    case QDialogButtonBox::DestructiveRole:
        close();
        break;
    }
}
