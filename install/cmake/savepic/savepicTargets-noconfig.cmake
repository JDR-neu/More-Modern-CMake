#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "savepic::savepic" for configuration ""
set_property(TARGET savepic::savepic APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(savepic::savepic PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libsavepic.so"
  IMPORTED_SONAME_NOCONFIG "libsavepic.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS savepic::savepic )
list(APPEND _IMPORT_CHECK_FILES_FOR_savepic::savepic "${_IMPORT_PREFIX}/lib/libsavepic.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
