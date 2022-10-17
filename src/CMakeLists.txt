find_package(fmt REQUIRED)
add_library(cmake_cpp_boilerplate_lib
    "../include/dummy.hpp"
    dummy.cpp)
add_library(cmake_cpp_boilerplate::lib ALIAS cmake_cpp_boilerplate_lib)
target_link_libraries(cmake_cpp_boilerplate_lib
        PUBLIC cmake_cpp_boilerplate::compiler_options fmt::fmt)
target_include_directories(cmake_cpp_boilerplate_lib PUBLIC "${PROJECT_SOURCE_DIR}/include")


# llvm

find_package(LLVM REQUIRED CONFIG)
add_definitions(${LLVM_DEFINITIONS})

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

llvm_map_components_to_libnames(llvm_libs
    Analysis
    Core
    ExecutionEngine
    InstCombine
    Object
    OrcJIT
    RuntimeDyld
    ScalarOpts
    Support
    native
)

target_link_libraries(cmake_cpp_boilerplate_lib PRIVATE ${llvm_libs})

if(${BP_BUILD_TESTS_COVERAGE})
    target_compile_options(cmake_cpp_boilerplate_lib PUBLIC -fprofile-arcs -ftest-coverage)
    target_link_libraries(cmake_cpp_boilerplate_lib PUBLIC gcov)
endif()

add_executable(cmake_cpp_boilerplate_app "main.cpp")
target_link_libraries(cmake_cpp_boilerplate_app PRIVATE cmake_cpp_boilerplate::lib)
