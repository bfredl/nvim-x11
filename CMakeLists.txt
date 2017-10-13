cmake_minimum_required(VERSION 2.8)

project(nvimX11)

add_library(nvimX11 MODULE src/nvimx11.c src/nvimx11.h)
target_link_libraries(nvimX11 X11 Xt)

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
