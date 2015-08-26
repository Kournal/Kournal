## Source files ##

# These dirs are xournalpp only so it's safe to add then recursively
file (GLOB_RECURSE kournal_SOURCES *.cpp)
set (kournal_SOURCES ${kournal_SOURCES} PARENT_SCOPE)


## Config files ##

# Main configuration file
configure_file ("config.hpp.in" "config.hpp" @ONLY)


## Additional options ##

option (CMAKE_LIST_SOURCES "Lists generated sources list" OFF)
mark_as_advanced (FORCE CMAKE_LIST_SOURCES)
if (CMAKE_LIST_SOURCES)
    message ("Sources list: ${kournal_SOURCES}")
endif ()

option (DEBUG_COMPILE "Pass -Wall to CXX_FLAGS" OFF)
mark_as_advanced (FORCE DEBUG_COMPILE)
if (DEBUG_COMPILE)
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
endif ()
