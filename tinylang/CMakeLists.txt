cmake_minimum_required(VERSION 3.13.4)

include(CMakePrintHelpers)

cmake_print_variables(CMAKE_SOURCE_DIR  CMAKE_CURRENT_SOURCE_DIR)
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  # Standalone
  message(STATUS "Building standalone")
  project(Tinylang)
  find_package(LLVM REQUIRED HINTS "${LLVM_CMAKE_PATH}")
  list(APPEND CMAKE_MODULE_PATH ${LLVM_DIR})
  include(AddLLVM)
  include(HandleLLVMOptions)
  include_directories("${LLVM_BINARY_DIR}/include" "${LLVM_INCLUDE_DIR}")
  link_directories("${LLVM_LIBRARY_DIR}")
  set(TINYLANG_BUILT_STANDALONE 1)
else()
  message(WARNING "Not building standalone")
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")

# USER must have seperate build directory
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR AND NOT MSVC_IDE)
  message(FATAL_ERROR "In-source builds are not allowed.")
endif()

# Put version string in build directory version of Version.inc file
set(TINYLANG_VERSION_STRING "0.1")
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/include/tinylang/Basic/Version.inc.in ${CMAKE_CURRENT_BINARY_DIR}/include/tinylang/Basic/Version.inc)

# include our wrappers arround AddLLVM macros (cmake/modules)
include(AddTinylang)

# our own includes
include_directories(BEFORE ${CMAKE_CURRENT_BINARY_DIR}/include ${CMAKE_CURRENT_SOURCE_DIR}/include)

# recursively add our lib and tool cmakes
add_subdirectory(lib)
add_subdirectory(tools)
