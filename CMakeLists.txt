cmake_minimum_required(VERSION 3.10.2)

project("main")

add_library(main_shared SHARED main.cpp)

target_link_libraries(main_shared)

add_library(main_static STATIC main.cpp)

target_link_libraries(main_static)

add_executable(main_executable main.cpp)

set_target_properties(
    main_executable
    PROPERTIES
    SUFFIX ".${GITHUB_ACTIONS_PREBUILD_SHARED_LIBRARY_EXTENSION}"
)

target_link_libraries(main_executable)
