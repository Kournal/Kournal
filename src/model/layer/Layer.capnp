@0xeb4a6b2ad3294929;

#
# Kournal Binary Journal  layer definition
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

struct Layer @0xd8d7248255e89bd2 {
    # Layer definition, BasicMetadata is not used, because of no need for timestamps or thumbnail

    name @0 :Text;              # Name of layer
    description @1 :Text;       # Description of layer

    opacity @2 :UInt8;          # Alpha channel of layer

    visible @3 :Bool;           # Is it currently visible?
    locked @4 :Bool;            # Is it currently accessible?
}
