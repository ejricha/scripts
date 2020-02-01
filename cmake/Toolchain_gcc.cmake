# Toolchain_gcc.cmake

# Set the compiler
set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)

# Compile with concepts for g++
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fconcepts")
