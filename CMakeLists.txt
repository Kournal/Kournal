cmake_minimum_required (VERSION 2.8.12)

## Project constants ##

project ("kournal" CXX C)
set (PROJECT_NAME_UC "Kournal")
set (PROJECT_VERSION "0.a")
set (PROJECT_STRING "${PROJECT_NAME} ${PROJECT_VERSION}")
set (PROJECT_URL "https://github.com/Kournal/Kournal")


## CMake setup ##

# Additional CMake includes
set (CMAKE_MODULE_PATH
    "${PROJECT_SOURCE_DIR}/cmake/include"
    "${PROJECT_SOURCE_DIR}/cmake/find"
)

include (FeatureSummary)

# Find includes in corresponding build directories
set (CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set (CMAKE_AUTOMOC ON)
# Automatically process resource files
set (CMAKE_AUTORCC ON)

if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to 'Debug' as none was specified.")
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release")
endif()


## Libraries ##

# Qt5
find_package (Qt5 REQUIRED Core Gui LinguistTools Widgets)
add_definitions (-DQT_NO_CAST_FROM_ASCII -DQT_NO_CAST_TO_ASCII)

# Cap'n'proto
find_package (CapnProto)    # Should be REQUIRED, but unexpectedly it's not found despite it's working
add_definitions (${CAPNP_DEFINITIONS})

# yaml-cpp
find_package (YamlCpp REQUIRED)
add_definitions ("-fexceptions")

# Includes
include_directories (
    "${PROJECT_SOURCE_DIR}/src"
    "${PROJECT_BINARY_DIR}/src"
    ${CAPNP_INCLUDE_DIRS}
    ${YAMLCPP_INCLUDE_DIR}
)

# Libraries
set (kournal_LIBRARIES
    Qt5::Core
    Qt5::Gui
    Qt5::Widgets
    ${CAPNP_LIBRARIES}
    ${YAMLCPP_LIBRARY}
)


## Other requirements and configuration ##

# C++11
include (C++11)
CheckCXX11(FATAL_ERROR)

# Git repository info
set (PROJECT_DEFAULT_BUGREPORT "https://github.com/Kournal/Kournal/issues/new")
include (GitRepo)


## Sources ##

add_subdirectory (src/model/journal)
capnp_generate_cpp (kournal_CAPNP_SOURCES kournal_CAPNP_HEADERS ${kournal_CAPNPFILES})

add_subdirectory (src/ui)
qt5_wrap_ui(kournal_UISOURCES ${kournal_UI})

add_subdirectory (src)

## Translations ##

file (GLOB_RECURSE kournal_TSSOURCES "i18n/*.ts")
qt5_add_translation(kournal_QM ${kournal_TSSOURCES})
#add_subdirectory (i18n) # For update_ts target NYI

if (${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    set (TR_SEARCH_PATH "${PROJECT_BINARY_DIR}")
else ()
    set (TR_SEARCH_PATH "${CMAKE_INSTALL_PREFIX}/share/${PROJECT_NAME}/i18n")
endif ()

configure_file ("src/config-i18n.hpp.in" "src/config-i18n.hpp" @ONLY)

## Final ##

add_executable (kournal
    ${kournal_SOURCES}
    ${kournal_UISOURCES}
    ${kournal_CAPNP_SOURCES}
    ${kournal_CAPNP_HEADERS}
    ${kournal_QM}
)

target_link_libraries (kournal ${kournal_LIBRARIES})

install (TARGETS kournal
    RUNTIME DESTINATION bin
)

install (FILES ${kournal_QM}
  DESTINATION "share/${PROJECT_NAME}/i18n"
  COMPONENT kournal
)


feature_summary (WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
