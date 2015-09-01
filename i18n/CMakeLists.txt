# Generate ts files target
#add_custom_command (OUTPUT


qt5_create_translation(QM ${kournal_SOURCES} ${kournal_UISOURCES} ${kournal_TSSOURCES})
add_custom_target (generate_ts
    SOURCES ${QM}
)

#file (COPY ${TMP_TS}
#      DESTINATION "${PROJECT_SOURCE_DIR}/i18n"
#)
