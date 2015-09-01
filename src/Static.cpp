#include "Static.hpp"

KournalWindow *Static::parent;
SettingsHandler *Static::settings;

void Static::setParent(KournalWindow *parent)
{
    // It should be constant
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
