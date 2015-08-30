@0x83b6160a2299fcbe;

#
# Kournal Binary Journal  document page definition
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
using import "Background.capnp".Background;
using import "Object.capnp".Object;

struct Page @0x9870036b8decf65c {
    # Single page of the document in tab

    dimensions @0 :Common.U32PointCoords;   # Dimensions of page
    background @1 :Background;              # Page background definition
    objects @2 :List(Object);               # List of objects
}
