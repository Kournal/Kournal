## Libraries ##

# Qt5
find_package (Qt5 REQUIRED Widgets Core Gui)

# Cap'n'proto
find_package (CapnProto REQUIRED)
add_definitions(${CAPNP_DEFINITIONS})


## Source files ##

include_directories (
    "${PROJECT_SOURCE_DIR}/src"
    ${CAPNP_INCLUDE_DIRS}
)

# These dirs are xournalpp only so it's safe to add then recursively
unset (kournal_SOURCES)
file (GLOB_RECURSE kournal_SOURCES *.cpp)

capnp_generate_cpp(CAPNP_SOURCES CAPNP_HEADERS "model/formats/kbj/kbj.capnp")


## Config files ##

# Main configuration file
configure_file ("config.h.in" "config.h" @ONLY)


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


## C++11 ##

include(CheckCXXCompilerFlag)
check_cxx_compiler_flag ("-std=c++11" COMPILER_SUPPORTS_CXX11)
check_cxx_compiler_flag ("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
if (COMPILER_SUPPORTS_CXX11)
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif (COMPILER_SUPPORTS_CXX0X)
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else ()
    message (STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif ()


## Final ##

add_executable (kournal
    ${kournal_SOURCES}
    "${CAPNP_SOURCES}"
    "${CAPNP_HEADERS}"
)

target_link_libraries (kournal
    Qt5::Core
    Qt5::Gui
    Qt5::Widgets
    ${CAPNP_LIBRARIES}
)

install (TARGETS kournal RUNTIME DESTINATION bin)
