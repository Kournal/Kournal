@0xb1fff6f6917f609a;

#
# Kournal Binary Journal  Cap'n'proto file format scheme
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

# Disclaimer: Until Kournal lays in alpha state this is only a draft and in future it'll be surely changed without
#             warning nor preserving backwards compatibility. Therefore it shouldn't be used in production environment.
#             Some properties in this scheme are waiting for implementation and can be presumed as preview of future
#             Kournal functions.

using import "Common.capnp".BasicMetadata;
using import "tab/DocumentTab.capnp".Tab;
using import "resource/Resource.capnp".Resource;

struct Journal @0x9707008195388520 {
    # Base Kournal Binary Journal file struct

    metadata @0 :BasicMetadata;         # Document metadata (thumbnail defined by user, default last view of last tab)
    author @1 :Text;                    # Author of document
    additional @2 :Text;                # Additional variable JSON data

    lastTab @3 :UInt32;                 # Last used tab
    tabs @4 :List(Tab);                 # List of document tabs

    resourceIndex @5 :List(UInt32);     # List with resource ids – no need to get all resources to see only one
    resources @6 :List(Resource);       # List of resource objects – index corresponding to pageIndex
}
