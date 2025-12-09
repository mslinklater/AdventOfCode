cmake_minimum_required(VERSION 3.25)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(aocpp LANGUAGES CXX)

include_directories(".")

set(UTILS
    utils/utils.cpp
)

set(2025SOURCES
    2025/2025day1.cpp
)

add_executable(aocpp ${UTILS} ${2025SOURCES} main.cpp)
