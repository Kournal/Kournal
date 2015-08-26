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
set (CMAKE_AUTOUIC ON)
# Automatically process resource files
set (CMAKE_AUTORCC ON)


## Git repository info ##

set (PROJECT_DEFAULT_BUGREPORT "https://github.com/Kournal/Kournal/issues/new")
include (GitRepo)


## Main project app ##

add_subdirectory(src)
