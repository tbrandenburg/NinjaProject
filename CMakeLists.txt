cmake_minimum_required(VERSION 3.2)  # CMake version check
project(ninjaproject)                # Create project "ninjaproject"
set(CMAKE_CXX_STANDARD 14)           # Enable c++14 standard

# Add main.cpp file of project root directory as source file
set(SOURCE_FILES main.cpp auxiliary.cpp)

# Add executable target with source files listed in SOURCE_FILES variable
add_executable(ninjaproject ${SOURCE_FILES})
