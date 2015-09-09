@0x8191d441dddf43c0;

#
# Kournal Binary Journal  document tab definition (kind of mandatory subdocument)
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
using import "DocumentCommon.capnp".DocumentView;
using import "../page/Page.capnp".Page;
using import "../layer/Layer.capnp".Layer;
using import "../bookmark/Bookmark.capnp".Bookmark;

struct Document @0x85132b574bd1c03b {
    # Defines document tab

    metadata @0 :Common.BasicMetadata;      # Document metadata (thumbnail of `lastView` or defined by user)
    color @1 :UInt32;                       # Document tab color in RGB (no alpha channel!)
    additional @2 :Text;                    # Additional variable JSON data
    pagination @3 :PaginationType;

    lastView @4 :DocumentView;              # Last view of document

    pageIndex @5 :List(Common.PageCoords);  # List of page coordinates – no need to get entire document to see only part
    pages @6 :List(Page);                   # List of pages – index corresponding to pageIndex

    layers @7 :List(Layer);
    bookmarks @8 :List(Bookmark);
}

enum PaginationType @0xd15a9c30c8fe33dc {
    # Type of tab

    page @0;        # Classic paginated document
    scroll @1;      # Single scroll of paper
    sCartesian @2;  # 2D cartesian signed space
    uCartesian @3;  # 2D cartesian unsigned space
}
