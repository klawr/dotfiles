# Replace everything prepended with My:
cmake_minimum_required(VERSION 3.19)

project(
    MyProjectName
    VERSION 0.1
    LANGUAGES CXX)

# Add imported library
add_library(MyLibraryName SHARED IMPORTED)
target_include_directories(MyLibraryName INTERFACE include)
set_target_properties(MyLibraryName PROPERTIES
    IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/lib/MyLibraryName.dll
    IMPORTED_IMPLIB ${CMAKE_CURRENT_SOURCE_DIR}/lib/MyLibraryName.lib
)

# Add executable
add_executable(MyProjectName src/MyProjectName.cpp)
target_link_libraries(MyProjectName PUBLIC MyLibraryName)
