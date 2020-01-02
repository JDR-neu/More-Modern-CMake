# ./library/CMakeLists.txt -- More Modern CMake

# Requires CMake 3.12, but also works with 3.13 policies set.
cmake_minimum_required( VERSION 3.12...3.13 )

project( MathLibs
         VERSION 1.0.0
         DESCRIPTION "The internal math-libraries." )

# An OBJECT-library, used to only compile common sources once
# which are used in both math-libraries.
# object-library，用来避免生成不同库的时候用到相同的文件，而重复编译相同的文件；同时相比于生成普通的库，不会真正产生库文件。
# 详细解释：https://gitlab.kitware.com/cmake/community/wikis/doc/tutorials/Object-Library
add_library( basicmath_ObjLib OBJECT )
target_sources( basicmath_ObjLib
    PRIVATE   "src/BasicMath.cpp"
              "src/HeavyMath.cpp"  # Takes loooooong to compile!
    PUBLIC    "${CMAKE_CURRENT_SOURCE_DIR}/include/Math.h"
    INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/include/MathAPI.h" )

# Required include search-paths and constexpr support.
target_include_directories( basicmath_ObjLib
    PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include" )
target_compile_features( basicmath_ObjLib
    PUBLIC cxx_constexpr )

# Requires "Boost.Outcome" (which has some requirements, too).
# CMake 3.12之前，object-library是不能使用target_link_libraries的。
target_link_libraries( basicmath_ObjLib PUBLIC Boost::outcome )

# A shared library for basic-math functionality.
add_library( basicmath SHARED )
target_link_libraries( basicmath PUBLIC basicmath_ObjLib )

# A shared library for advanced-math functionality.
add_library( extmath SHARED )
target_sources( extmath
    PRIVATE "src/ExtendedMath.cpp" )  # Premium-content!
target_link_libraries( extmath PUBLIC basicmath_ObjLib )
# "Boost.Graph" is an additional dependency.
target_link_libraries( extmath PRIVATE Boost::graph )

# Create ALIAS targets.
add_library( MyCalc::basicmath ALIAS basicmath )
add_library( MyCalc::extmath ALIAS extmath )
# 不明白为什么MyCalc::extmath等这两个可以直接在外层使用？
