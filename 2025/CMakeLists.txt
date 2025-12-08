cmake_minimum_required(VERSION 3.25)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(aoc2025 LANGUAGES CXX)

include_directories("..")

add_executable(day1 day1.cpp)
add_executable(day2 day2.cpp)
add_executable(day3 day3.cpp)
add_executable(day4 day4.cpp)