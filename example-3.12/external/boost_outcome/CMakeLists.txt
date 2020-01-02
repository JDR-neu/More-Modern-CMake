# ./external/boost_outcome/CMakeLists.txt -- More Modern CMake

# Requires CMake 3.12, but also works with 3.13 policies set.
cmake_minimum_required( VERSION 3.12...3.13 )

project( External.Reviewed_Boost.outcome
         VERSION 2.0
         DESCRIPTION "Boost.Outcome header-only lib." )

# Provide target for "Boost.Outcome" library.
add_library( Reviewed_Boost.outcome INTERFACE
    IMPORTED GLOBAL ) #IMPORTED表示这是一个外面导入的库；GLOBAL表示声明成一个全局标量。
# Store include search-path containing headers
# of "Boost.Outcome".
target_include_directories( Reviewed_Boost.outcome SYSTEM
    INTERFACE /opt/boost-outcome/include )
# Require at least compiling with C++14.
target_compile_features( Reviewed_Boost.outcome
    INTERFACE cxx_std_14 )

# Create an alias for "Boost.Outcome".
add_library( Boost::outcome ALIAS Reviewed_Boost.outcome )
# 3.10: imported target是不能用在ALIAS右边的。 3.10的例子中就没有这样用。
# 3.12: global的imported target可以用在ALIAS右边，正如现在的情况。
# 既然boost-outcome是一个纯头文件的库，为什么不直接包含头文件，而是生成一个imported库？是因为这样可以指定一些property，如至少C++14. 这应该也是CMAKE标准的写法。
# 是不是说如果boost/CMakelists中，如果boost没有按照modern CMake的写法提供boost::graph等，那么就需要自己生成一个imported库？
# 可以参考： http://mesos.apache.org/documentation/latest/cmake-examples/