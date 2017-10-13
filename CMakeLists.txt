cmake_minimum_required(VERSION 2.8)

project(nvimX11)


find_path(MSGPACK_INCLUDE_DIR msgpack.hpp)
include_directories(${MSGPACK_INCLUDE_DIR})

include_directories( ${CMAKE_CURRENT_BINARY_DIR} )

add_library(nvimX11 MODULE src/nvimx11.c src/nvimx11.h)

#target_link_libraries(test_cxx ${Boost_LIBRARIES})

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
