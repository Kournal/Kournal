# Prepare kouranl_TSSOURCES for qt5_add_translation
file (GLOB_RECURSE kournal_TSSOURCES "i18n/*.ts")
set (kournal_TSSOURCES ${kournal_TSSOURCES} PARENT_SCOPE)

option (TRANSLATION_UPDATER "If CMake should add support for updating/adding translation files" ON)
if (TRANSLATION_UPDATER)

    # Prepare sources list for update_ts target
    file (GLOB_RECURSE sources_cpp RELATIVE "${PROJECT_SOURCE_DIR}" "${PROJECT_SOURCE_DIR}/src/*.cpp")
    file (GLOB_RECURSE sources_ui RELATIVE "${PROJECT_SOURCE_DIR}" "${PROJECT_SOURCE_DIR}/src/ui/*.ui")
    set (sources ${sources_cpp} ${sources_ui})

    # Filter unneeded source files
    if (EXISTS "${PROJECT_SOURCE_DIR}/i18n/filter.txt")
        file (STRINGS "filter.txt" sources_FILTER)
        if (sources_FILTER)
            list (REMOVE_ITEM sources ${sources_FILTER})
        endif ()
    endif ()

    # Generate `sources.txt` file for use with `update.py`
    file (REMOVE "${PROJECT_SOURCE_DIR}/i18n/sources.txt")
    foreach (source IN LISTS sources)
        file (APPEND "${PROJECT_SOURCE_DIR}/i18n/sources.txt" "${source}\n")
    endforeach (source)

    # Check for Python – required by update.py
    find_program (PYTHON_PATH python)
    if (NOT PYTHON_PATH)
        message (FATAL_ERROR "You must have Python installed to run update.py script. If you really don't like Python you can always disable TRANSLATION_UPDATER flag.")
    endif ()

    # Update script
    get_target_property(Qt5lupdate_location Qt5::lupdate LOCATION)
    configure_file ("${PROJECT_SOURCE_DIR}/i18n/update.py.in" "${PROJECT_SOURCE_DIR}/i18n/update.py" @ONLY)

    add_custom_target (update_ts
        COMMAND "${PROJECT_SOURCE_DIR}/i18n/update.py"
        DEPENDS kournal
    )

endif (TRANSLATION_UPDATER)
