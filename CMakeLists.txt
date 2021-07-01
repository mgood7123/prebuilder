cmake_minimum_required(VERSION 3.10.2)

project("main")

add_library(main SHARED main.cpp)

target_link_libraries(main)

add_executable(mainExecutable.${GITHUB_ACTIONS_PREBUILD_EXTENSION} main.cpp)

target_link_libraries(mainExecutable.${GITHUB_ACTIONS_PREBUILD_EXTENSION})
