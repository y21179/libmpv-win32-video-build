set(version "v3.26.4")

execute_process(
    COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules/ExternalProject
)

if(NOT EXISTS "${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules/setup_done")
    execute_process(
        COMMAND curl -sL "https://gitlab.kitware.com/cmake/cmake/-/archive/${version}/cmake-${version}.tar.gz?path=Modules/ExternalProject" -o modules.tar.gz
        COMMAND tar -C ${CMAKE_CURRENT_BINARY_DIR}/cmake --strip-components=1 -xf modules.tar.gz
        COMMAND curl -sLO https://gitlab.kitware.com/cmake/cmake/-/raw/${version}/Modules/ExternalProject.cmake
        COMMAND touch setup_done
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules
    )
    execute_process(
        COMMAND patch -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/packages/cmake-0001-ExternalProject-changes.patch
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cmake
    )
endif()

include(${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules/ExternalProject.cmake)
