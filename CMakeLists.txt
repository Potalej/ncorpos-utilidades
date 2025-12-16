cmake_minimum_required(VERSION 3.15)

project(utilidades LANGUAGES Fortran)

# --------------------------------------------------
# Biblioteca
# --------------------------------------------------
add_library(utilidades STATIC)

# --------------------------------------------------
# Onde os .mod vão ser gerados
# --------------------------------------------------
set_target_properties(utilidades PROPERTIES
  Fortran_MODULE_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}/mod
)

# --------------------------------------------------
# Tipos
# --------------------------------------------------
option(USE_EXTERNAL_TIPOS
       "Usando o modulo tipos da aplicacao"
       OFF)

# --------------------------------------------------
# Fontes Fortran
# --------------------------------------------------
target_sources(utilidades
  PRIVATE
    src/utilidades.f90
    include/tipos.F90
)

# ============================================================================
# Procura pelo OpenBLAS
# ----------------------------------------------------------------------------
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
find_package(OpenBLAS REQUIRED)

IF (NOT OpenBLAS_LIB)
  message(FATAL_ERROR "OpenBLAS nao encontrado!!!")
ENDIF()

target_link_libraries(utilidades PRIVATE ${OpenBLAS_LIB})
# ============================================================================

# --------------------------------------------------
# Diretórios de módulos / includes
# --------------------------------------------------
target_include_directories(utilidades
  PUBLIC
    ${CMAKE_CURRENT_BINARY_DIR}/mod
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)






# --------------------------------------------------
# Instalação (opcional, mas já preparado)
# --------------------------------------------------
# install(TARGETS utilidades
#   EXPORT utilidadesTargets
#   ARCHIVE DESTINATION lib
#   LIBRARY DESTINATION lib
# )

# install(DIRECTORY
#   ${CMAKE_CURRENT_BINARY_DIR}/mod/
#   DESTINATION include/utilidades
# )

# install(EXPORT utilidadesTargets
#   FILE utilidadesTargets.cmake
#   NAMESPACE utilidades::
#   DESTINATION lib/cmake/utilidades
# )