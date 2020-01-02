## Get the directory path of the <target>.cmake file
get_filename_component(savepic_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" DIRECTORY)
message("savepic_CMAKE_DIR: ${savepic_CMAKE_DIR}")

## Add the dependencies of our library
include(CMakeFindDependencyMacro)
find_dependency(OpenCV REQUIRED)
find_dependency(Eigen3 REQUIRED)

## Import the targets
if(NOT TARGET savepic::savepic)
    include("${savepic_CMAKE_DIR}/savepicTargets.cmake")
endif()