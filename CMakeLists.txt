cmake_minimum_required (VERSION 2.8.12)

## Project constants ##

project ("Kournal" CXX)
set (PROJECT_VERSION "0.a")
set (PROJECT_STRING "${PROJECT_NAME} ${PROJECT_VERSION}")
set (PROJECT_URL "https://github.com/Kournal/Kournal")


## CMake setup ##

# Additional CMake includes
include (FindPkgConfig)
set (CMAKE_MODULE_PATH
    "${PROJECT_SOURCE_DIR}/cmake/include"
    "${PROJECT_SOURCE_DIR}/cmake/find"
)

# Find includes in corresponding build directories
set (CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set (CMAKE_AUTOMOC ON)
# Automatically generate UI headers
#set (CMAKE_AUTOUIC ON)
# Automatically process resource files
set (CMAKE_AUTORCC ON)


## Libraries ##

# Qt5
find_package (Qt5 REQUIRED Widgets Core Gui)

# Cap'n'proto
find_package (CapnProto REQUIRED)
add_definitions(${CAPNP_DEFINITIONS})

# Includes
include_directories (
    "${PROJECT_SOURCE_DIR}/src"
    ${CAPNP_INCLUDE_DIRS}
)


## Other requirements and configuration ##

# C++11
include (C++11)
CheckCXX11(FATAL_ERROR)

# Git repository info
set (PROJECT_DEFAULT_BUGREPORT "https://github.com/Kournal/Kournal/issues/new")
include (GitRepo)


## Sources ##

add_subdirectory(ui)
qt5_wrap_ui (kournal_UISOURCES ${kournal_UIFILES})

add_subdirectory(src/model/formats/kbj)
capnp_generate_cpp(kournal_CAPNP_SOURCES kournal_CAPNP_HEADERS ${kournal_CAPNPFILES})

add_subdirectory(src)


## Final ##

add_executable (kournal
    ${kournal_SOURCES}
    ${kournal_UISOURCES}
    ${kournal_CAPNP_SOURCES}
    ${kournal_CAPNP_HEADERS}
)

target_link_libraries (kournal
    Qt5::Core
    Qt5::Gui
    Qt5::Widgets
    ${CAPNP_LIBRARIES}
)

install (TARGETS kournal RUNTIME DESTINATION bin)
