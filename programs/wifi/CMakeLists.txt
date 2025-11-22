cmake_minimum_required(VERSION 3.10)

set(PROJECT wifi)
project(${PROJECT})

set(CMAKE_CXX_COMPILER "clang++")
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_BUILD_TYPE Release)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
add_compile_options(-Wall -Wextra -pedantic -Werror -O2)

add_executable(${PROJECT} src/main.cpp)
target_include_directories(${PROJECT} PUBLIC "include")
