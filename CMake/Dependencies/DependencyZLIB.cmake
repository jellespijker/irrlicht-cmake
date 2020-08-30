# The ZLIB license
#
# Copyright (c) 2020 Jelle Spijker
#
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgement in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.
#

message(STATUS "Looking for ZLIP header and library...")

if(NOT USE_NON_SYSTEM_ZLIP)
    find_package(zlip)
    if (zlip_FOUND)
        MESSAGE(STATUS "zlip Correctly Found:")
        MESSAGE(STATUS " * Include-Dir: ${zlip_INCLUDE_DIRS}")
        MESSAGE(STATUS " * Libraries: ${lzlip_LIBRARIES}")
        INCLUDE_DIRECTORIES(${zlip_INCLUDE_DIRS})
        SET(IRRLICHT_DEPENDENCY_LIBRARIES
                ${IRRLICHT_DEPENDENCY_LIBRARIES}
                ${zlip_LIBRARIES}
                )
        SET (CMAKE_CXX_FLAGS_RELEASE
                "${CMAKE_CXX_FLAGS_RELEASE} -U_IRR_USE_NON_SYSTEM_ZLIB_ -U_IRR_USE_NON_SYSTEM_BZLIB_"
                )
        SET (CMAKE_C_FLAGS_RELEASE
                "${CMAKE_C_FLAGS_RELEASE} -U_IRR_USE_NON_SYSTEM_ZLIB_ -U_IRR_USE_NON_SYSTEM_BZLIB_"
                )
    else ()
        MESSAGE(STATUS "zlip missing")
    endif ()
endif()