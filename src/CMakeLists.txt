## Source files ##

file (GLOB_RECURSE kournal_SOURCES *.cpp)
set (kournal_SOURCES ${kournal_SOURCES} PARENT_SCOPE)


## Additional options ##

option (CMAKE_LIST_SOURCES "List generated sources list" OFF)
if (CMAKE_LIST_SOURCES)
    message ("Sources list: ${kournal_SOURCES}")
endif ()

option (DEBUG_COMPILE "Pass -Wall to CXX_FLAGS" OFF)
if (DEBUG_COMPILE)
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
endif ()

mark_as_advanced (FORCE CMAKE_LIST_SOURCES DEBUG_COMPILE)


## Config files ##

# Main configuration file
configure_file ("config.hpp.in" "config.hpp" @ONLY)

# Developement configuration file
configure_file ("config-dev.hpp.in" "config-dev.hpp" @ONLY)
