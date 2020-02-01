# Common.cmake
#
# Variables that should be set in all projects

# Requires version 3.15 of CMake
cmake_minimum_required(VERSION 3.15)

# Default to Release build
set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug/Release/RelWithDebInfo/MinSizeRel")

# We need at least C++17 to run
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Treat warnings as errors
set(FLAGS_NORMAL "-Wall -Wextra -pedantic -Werror")
set(FLAGS_CUSTOM "-Wconversion -Wfloat-equal -Wswitch-default -Wformat=2 -Wmissing-include-dirs -Wdisabled-optimization -Wunused-result -Winvalid-pch")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAGS_NORMAL} ${FLAGS_CUSTOM}")

# Use colorful output by default
option(COLOR_OUTPUT "Always produce ANSI-colored output (GNU/Clang only)" TRUE)
if(COLOR_OUTPUT)
	if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		add_compile_options(-fdiagnostics-color=always)
	elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
		add_compile_options(-fcolor-diagnostics)
	endif()
endif()

# Change the default flags for different build types
# Debug
set(CMAKE_C_FLAGS_DEBUG "-Og -g3")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g3")
# RelWithDebInfo
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O3 -g2 -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O3 -g2 -DNDEBUG")
# Release
set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
# MinSizeRel
set(CMAKE_C_FLAGS_MINSIZEREL "-Os -DNDEBUG")
set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -DNDEBUG")

# Macro to add a simple executable
macro(add_executable_cpp NAME)
	set(BIN "${NAME}")
	set(CPP "${NAME}.cpp")
	message("Building ${BIN} from ${CPP}")
	add_executable(${BIN} ${CPP})
endmacro()
