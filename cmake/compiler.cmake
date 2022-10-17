# Compiler specific settings

if(compiler_included)
  return()
endif()
set(compiler_included true)

# Link this 'library' to use the standard warnings
add_library(cmake_cpp_boilerplate_compiler_options INTERFACE)
add_library(cmake_cpp_boilerplate::compiler_options ALIAS cmake_cpp_boilerplate_compiler_options)

option(BP_ENABLE_PCH "Enable Precompiled Headers" OFF)
if (BP_ENABLE_PCH)
  target_precompile_headers(cmake_cpp_boilerplate_compiler_options INTERFACE
          <algorithm>
          <array>
          <vector>
          <string>
          <utility>
          <functional>
          <memory>
          <memory_resource>
          <string_view>
          <cmath>
          <cstddef>
          <type_traits>
          )
endif ()

option(BP_USE_ASAN "Enable the Address Sanitizers" OFF)
if(BP_USE_ASAN)
  message("Enable Address Sanitizer")
  target_compile_options(cmake_cpp_boilerplate_compiler_options INTERFACE
          -fsanitize=address -fno-omit-frame-pointer)
  target_link_libraries(cmake_cpp_boilerplate_compiler_options INTERFACE
          -fsanitize=address)
endif()

option(BP_USE_TSAN "Enable the Thread Sanitizers" OFF)
if(BP_USE_TSAN)
  message("Enable Thread Sanitizer")
  target_compile_options(cmake_cpp_boilerplate_compiler_options INTERFACE
          -fsanitize=thread)
  target_link_libraries(cmake_cpp_boilerplate_compiler_options INTERFACE
          -fsanitize=thread)
endif()

option(BP_USE_MSAN "Enable the Memory Sanitizers" OFF)
if(BP_USE_MSAN)
  message("Enable Memory Sanitizer")
  target_compile_options(cmake_cpp_boilerplate_compiler_options INTERFACE
          -fsanitize=memory -fno-omit-frame-pointer)
  target_link_libraries(cmake_cpp_boilerplate_compiler_options INTERFACE
          -fsanitize=memory)
endif()

option(BP_USE_UBSAN "Enable the Undefined Behavior Sanitizers" OFF)
if(BP_USE_UBSAN)
  message("Enable Undefined Behavior Sanitizer")
  target_compile_options(cmake_cpp_boilerplate_compiler_options INTERFACE
          -fsanitize=undefined)
  target_link_libraries(cmake_cpp_boilerplate_compiler_options INTERFACE
          -fsanitize=undefined)
endif()