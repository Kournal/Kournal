#include "KournalWindow.hpp"
#include "ui_KournalWindow.h"

#include "SettingsDialog.hpp"
#include "Static.hpp"

#include <QFileDialog>
#include <QMessageBox>
#include <QStandardPaths>

KournalWindow::KournalWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::KournalWindow)
{
    // Settings setup
    Static::setSettings(new SettingsHandler(this, true));

    // UI setup
    ui->setupUi(this);

    connect(ui->actionClose, SIGNAL(triggered()), this, SLOT(close()));

    welcome = new WelcomeWidget(this);
    ui->fileTabs->addTab(welcome, QStringLiteral("Welcome"));  // TODO – add icon
}

KournalWindow::~KournalWindow()
{
    delete ui;
}

void KournalWindow::on_fileTabs_tabCloseRequested(int index)
{
    if (dynamic_cast<WelcomeWidget *>(ui->fileTabs->widget(index)))
    {
        ui->fileTabs->removeTab(index);
    }
}

void KournalWindow::on_actionOpenJournal_triggered()
{
    QString fileName = QFileDialog::getOpenFileName(this, QStringLiteral("Open Journal"),
        QStandardPaths::standardLocations(QStandardPaths::HomeLocation).first(),
        QStringLiteral("Kournal Binary Journal files (*.kbj)"));

    // TODO
}

void KournalWindow::on_actionOptions_triggered()
{
    SettingsDialog settings;
    settings.exec();
}

void KournalWindow::on_actionAboutQt_triggered()
{
    QMessageBox::aboutQt(this, QStringLiteral("About Qt"));
}
