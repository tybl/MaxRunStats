################################################################################
# License: The Unlicense (https://unlicense.org)
################################################################################
cmake_minimum_required(VERSION 3.14) # FetchContent_MakeAvailable

project(MaxRunStats
  VERSION 0.0.1
  DESCRIPTION "Parse TCX files into a graph representing your distance versus time"
  LANGUAGES CXX)

option(BUILD_ALL_TESTS "Build and run tests as a subproject" OFF)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  include(CTest)
endif()
include(FetchContent)
include(util/cmake/CompilerSettings.cmake)
include(util/cmake/Linters.cmake)

find_package(SFML COMPONENTS graphics REQUIRED)
find_package(Eigen3 REQUIRED)

# Use doctest as unit test framework
FetchContent_Declare(doctest
  GIT_REPOSITORY https://github.com/onqtam/doctest.git
  GIT_SHALLOW    TRUE
  GIT_TAG        "2.4.1")
FetchContent_MakeAvailable(doctest)

# Use pugixml to parse XML
FetchContent_Declare(pugixml
  GIT_REPOSITORY https://github.com/zeux/pugixml.git
  GIT_SHALLOW    TRUE
  GIT_TAG        "v1.10")
FetchContent_MakeAvailable(pugixml)


FetchContent_Declare(date
  GIT_REPOSITORY https://github.com/HowardHinnant/date.git
  GIT_SHALLOW    TRUE
  GIT_TAG        "v3.0.0")
FetchContent_MakeAvailable(date)

add_subdirectory(app)

if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME) OR BUILD_ALL_TESTS)
  add_subdirectory(test)
endif()
