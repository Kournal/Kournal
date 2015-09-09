@0xe10e7a3dea52ce14;

#
# Kournal Binary Journal  common tab structs
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

struct DocumentView @0xced2c65c87033d2f {
    # State of tab – position and zoom of middle point of view

    page @0 :Common.PageCoords;     # Coordinates/position of page
    point @1 :Common.F64Coords;     # Coordinates of middle point of view on `page`
    scale @2 :Float64;              # Scaling of view
}
