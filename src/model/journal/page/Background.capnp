@0xdd421216896adb24;

#
# Kournal Binary Journal  document page background definition
#
# Kournal
# Copyright (C) 2015  Marek Pikuła
# https://github.com/Kournal/Kournal
#
# This file is part of Kournal.
#
# Kournal is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later version.
#
# Kournal is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with Kournal.
# If not, see <http://www.gnu.org/licenses/>.
#

using Common = import "../Common.capnp";

struct Background @0xc493cb4b6948964c {
    # Defines background style

    union {
        copy @0 :Common.PageCoords;     # Just copy background from specific page (preserving offset)

        custom :group {                 # Introduce new background
            type @1 :BackgroundType;

            resourceNo @2 :UInt32;      # Reference to resource if needed
            resourceParams @3 :Text;    # Parameters of resource in JSON (ie. region, page)
        }
    }
}

enum BackgroundType @0xdd88bbb73c9d3313 {
    graph @0;
    lined @1;
    ruled @2;
    image @3;       # QPixmap compatible external image or SVG
    document @4;    # External document
    custom @5;      # Custom background – description lays in resource
}
