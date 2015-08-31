cmake_minimum_required (VERSION 2.8.12)

## Project constants ##

project ("Kournal" CXX C)
set (PROJECT_VERSION "0.a")
set (PROJECT_STRING "${PROJECT_NAME} ${PROJECT_VERSION}")
set (PROJECT_URL "https://github.com/Kournal/Kournal")


## CMake setup ##

# Additional CMake includes
find_package (ECM 1.0.0 REQUIRED NO_MODULE) # For KF5
set (CMAKE_MODULE_PATH
    "${PROJECT_SOURCE_DIR}/cmake/include" "${PROJECT_SOURCE_DIR}/cmake/find"
    ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR}
)

include (KDEInstallDirs)
include (KDECMakeSettings)
include (KDECompilerSettings)
include (FeatureSummary)

# Find includes in corresponding build directories
set (CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set (CMAKE_AUTOMOC ON)
# Automatically generate UI headers
set (CMAKE_AUTOUIC ON)
# Automatically process resource files
set (CMAKE_AUTORCC ON)


## Libraries ##

# Qt5
find_package (Qt5 REQUIRED Widgets Core Gui)
add_definitions (-DQT_NO_CAST_FROM_ASCII -DQT_NO_CAST_TO_ASCII)

# KF5
find_package (KF5 REQUIRED COMPONENTS CoreAddons I18n)

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
    Qt5::Widgets
    KF5::CoreAddons
    KF5::I18n
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

add_subdirectory(src/model/journal)
capnp_generate_cpp(kournal_CAPNP_SOURCES kournal_CAPNP_HEADERS ${kournal_CAPNPFILES})

add_subdirectory(src)


## Final ##

add_executable (kournal
    ${kournal_SOURCES}
    ${kournal_UISOURCES}
    ${kournal_CAPNP_SOURCES}
    ${kournal_CAPNP_HEADERS}
)

target_link_libraries (kournal ${kournal_LIBRARIES})

install (TARGETS kournal RUNTIME DESTINATION bin)

feature_summary (WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
