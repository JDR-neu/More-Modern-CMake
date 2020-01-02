# 参考： https://www.jianshu.com/p/3711361d10a5
cmake_minimum_required(VERSION 3.12)
project(cmake_template)

find_package(Eigen3 REQUIRED)
find_package(OpenCV 3.1 REQUIRED)

add_library(savepic SHARED) # cmake 3.11以下，这样写会报警告，默认至少要跟一个cpp文件。
## 以下实际上都是在设置savepic库的properties。
target_compile_features(savepic PRIVATE cxx_std_11) #设置
target_sources(savepic PRIVATE src/save_pic.cpp)
target_include_directories(savepic
        PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/savepic> # expression-generator 暂时还不太清楚用法
        ${OpenCV_INCLUDE_DIRS} # OpenCV包含在头文件savepic.hpp中了，cpp文件中也用到，所以这个include目录既要传给savepic库的usage-requirement，也要传给其build-requirement，故设为PUBLIC。
        PRIVATE
        ${EIGEN3_INCLUDE_DIR} # Eigen库只在cpp文件中包含，不涉及接口，故设为PRIVATE。
        )
target_link_libraries(savepic PUBLIC ${OpenCV_LIBS} PRIVATE ${EIGEN3_LIBRARIES}) # 相应链接库文件

#install
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/install") #如果没有空格，加不加引号都是无所谓的；但是目录中很可能有空格，所以目录最好加引号！
install(TARGETS savepic
        EXPORT savepicTargets # 导出savepicTargets.cmake，是自动生成的。
        LIBRARY DESTINATION lib) # shared库的关键字是LIBRARY。静态的是ARCHIVE，可执行文件是RUNTIME。
install(DIRECTORY include/savepic/ # 如果只写include/，那么实际上安装的是savepic/文件夹。
        DESTINATION include)
# 这里安装到${CMAKE_INSTALL_PREFIX}/include，会自动添加一个同名文件夹，也就是实际上头文件
# 放在${CMAKE_INSTALL_PREFIX}/savepic。所以如果上面一句话只写include/，那么别的程序调用时，
# 需要包含savepic/savepic/xxx.hpp，不合理。
install(EXPORT savepicTargets # 对应上面的savepicTargets.cmake，将其安装到安装目录的cmake文件夹。
        NAMESPACE savepic:: # 之后别的程序调用的时候，需要写savepic::savepic，就跟osqp一样。
        DESTINATION cmake/savepic)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/cmake/savepicConfig.cmake # 这个文件是自己写的。
        DESTINATION ${CMAKE_INSTALL_PREFIX}/cmake/savepic) # 安装到指定位置。
