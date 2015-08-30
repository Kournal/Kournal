@0xf050c277e9bae3c1;

#
# Kournal Binary Journal  common structs
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

struct BasicMetadata @0x947c65e448dd7d50 {
    # Universal basic metadata struct for all kinds of thumbnailable objects

    name @0 :Text;                  # Object name
    description @1 :Text;           # Object description

    created @2 :UInt64;             # POSIX time when object was created
    modified @3 :UInt64;            # POSIX time when object was modified

    thumbnail @4 :Data;             # QPixmap compatible thumbnail of object
}

struct U32PointCoords @0xa3ebcb4df9ad460c {
    # Unsigned point coordinates (or dimensions representation)

    x @0 :UInt32;                   # X coordinate or width
    y @1 :UInt32;                   # Y coordinate or height
}

struct S32PointCoords @0xcd5d4b7a926774e8 {
    # Signed point coordinates

    x @0 :Int32;
    y @1 :Int32;
}

struct F64Coords @0xa314f46e28416d37 {
    # Float64 coordinates, where speed is not that big issue and conversion may be performed while initialization

    x @0 :Float64;
    y @1 :Float64;
}

struct F32Coords @0x80403e892b80cb36 {
    # Float32 coordinates – Float64 is not used here because qreal on ARM is float (everywhere else it's double)
    # 64-bit float on ARM may (or may not, who knows) be slower than 32-bit as I read somewhere and while
    # converting it'd loose precious precision

    x @0 :Float32;
    y @1 :Float32;
}

struct PageCoords @0xbcf789b5a83be597 {
    # Coordinates of page on tab depending on pagination type

    union {
        pageNo @0 :UInt32;          # Number of page if `type == page` or number of segment if `type == scroll`

        sCoords :group {            # Signed coordinates of segment for `type == sCartesian`
            x @1 :Int16;
            y @2 :Int16;
        }

        uCoords :group {            # Unsigned coordinates of segment for `type == uCartesian`
            x @3 :UInt16;
            y @4 :UInt16;
        }
    }
}

struct F32Rectangle @0x862b0ec13a0fb2ab {
    # Float32 rectangle

    corner @0 :F32Coords;           # Top-left corner of selection
    size @1 :F32Coords;             # x = width and y = height
}

struct F32RegionEntireSel @0x9b0aab365a0ef328 {
    # Union of entire page/image/object or Float32 region cut from it

    union {
        entire @0 :Void;            # Import entire page
        region @1 :F32Rectangle;    # Region to import
    }
}
