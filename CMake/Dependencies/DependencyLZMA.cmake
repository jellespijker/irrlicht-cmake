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

message(STATUS "Looking for LZMA header and library...")

if(NOT USE_NON_SYSTEM_LZMA)
    find_package(lzma)
    if (lzma_FOUND)
        MESSAGE(STATUS "LZAM Correctly Found:")
        MESSAGE(STATUS " * Include-Dir: ${lzma_INCLUDE_DIRS}")
        MESSAGE(STATUS " * Libraries: ${lzma_LIBRARIES}")
        INCLUDE_DIRECTORIES(${lzma_INCLUDE_DIRS})
        SET(IRRLICHT_DEPENDENCY_LIBRARIES
                ${IRRLICHT_DEPENDENCY_LIBRARIES}
                ${lzma_LIBRARIES}
                )
    else ()
        MESSAGE(STATUS "lzma missing")
    endif ()
endif()