#include "Static.hpp"

KournalWindow *Static::parent;
SettingsHandler *Static::settings;

void Static::setParent(KournalWindow *parent)
{
    // It's const
    if (!Static::parent)
    {
        Static::parent = parent;
    }
}

SettingsHandler *Static::getSettings()
{
    if (!settings)
    {
        settings = new SettingsHandler(parent);
    }
    return settings;
}

void Static::setSettings(SettingsHandler *settings)
{
    Static::settings = settings;
}
