cmake_minimum_required(VERSION 3.30)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(aoc2024 LANGUAGES CXX)

include_directories("..")

add_executable(day1 day1.cpp)
add_executable(day2 day2.cpp)
add_executable(day3 day3.cpp)
add_executable(day4 day4.cpp)
add_executable(day5 day5.cpp)
add_executable(day6 day6.cpp)
add_executable(day7 day7.cpp)
add_executable(day8 day8.cpp)
add_executable(day9 day9.cpp)
