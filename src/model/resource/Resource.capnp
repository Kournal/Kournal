@0xd7671c092f8f9d31;

#
# Kournal Binary Journal  resource definition
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

using import "../Common.capnp".BasicMetadata;

struct Resource @0x935c5c9d0bda6fce {
    # Resource used in some place(s) of page

    metadata @0 :BasicMetadata;     # Resource metadata (pretty redundant, but why not?)
    prefix @1 :Text;                # Resource prefix path
    type @2 :ResourceType;          # Resource type

    visible @3 :Bool = true;        # If resource should be visible for user in resource explorer

    additional @4 :Text;            # Additional type specific variable JSON data
    data @5 :Data;                  # Main resource data

    enum ResourceType @0xc924d836bfe44d04 {
        text @0;                    # Text data
        pixmap @1;                  # Pixmap supported by QPixmap
        svg @2;                     # SVG file
        document @3;                # Document or part of it (defined in `additional`)
        customBackground @4;        # Custom written background for page
    }
}
