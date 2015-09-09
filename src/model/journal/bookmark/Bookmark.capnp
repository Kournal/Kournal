@0xea587a1583a1c9f7;

#
# Kournal Binary Journal  bookmark definition
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
using import "../document/DocumentCommon.capnp".DocumentView;

struct Bookmark @0xd91b55583e033c9e {
    # Bookmark of given view

    id @0 :UInt32;              # Unique ID of bookmark
    metadata @1 :BasicMetadata; # Bookmark metadata (thumbnail of view)
    view @2 :DocumentView;      # Bookmarked view
}
