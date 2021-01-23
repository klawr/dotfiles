cmake_minimum_required(VERSION 3.18)

project(hello_tf LANGUAGES CXX)

find_package(frugally-deep CONFIG REQUIRED)

add_executable(hello_tf src/hello_tf.cpp)
target_link_libraries(hello_tf PUBLIC frugally-deep)

# Forgetable snippets:

# if (WIN32)
# 	target_compile_definitions(hello_tf
#		PUBLIC
#		VC_EXTRALEAN=1
#		WIN32_LEAN_AND_MEAN=1
#		NOMINMAX=1
#	)
# endif()
