# Vendor the exact CMake v3.26.4 ExternalProject module set the 2023 patch was
# written against. Fetching it at build time broke when Kitware changed the
# gitclone template on master (git_clone_retries), so files live in-repo now.
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules-3264/ExternalProject.cmake
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules-3264/
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules/ExternalProject)
execute_process(
    COMMAND patch -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/packages/cmake-0001-ExternalProject-changes.patch
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cmake
    COMMAND_ERROR_IS_FATAL ANY
)
include(${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules/ExternalProject.cmake)
