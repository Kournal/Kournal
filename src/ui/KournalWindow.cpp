#include "KournalWindow.hpp"
#include "ui_KournalWindow.h"

#include <QFileDialog>
#include <QStandardPaths>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    connect(ui->actionClose, SIGNAL(triggered()), this, SLOT(close()));

    welcome = new WelcomeWidget(this);
    ui->fileTabs->addTab(welcome, "Welcome");  // TODO – add icon
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_fileTabs_tabCloseRequested(int index)
{
    if (dynamic_cast<WelcomeWidget *>(ui->fileTabs->widget(index)))
    {
        ui->fileTabs->removeTab(index);
    }
}

void MainWindow::on_actionOpenJournal_triggered()
{
    QString fileName = QFileDialog::getOpenFileName(this, "Open Journal",
        QStandardPaths::standardLocations(QStandardPaths::HomeLocation).first(),
        "Kournal Binary Journal files (*.kbj)");
}
