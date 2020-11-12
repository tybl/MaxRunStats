################################################################################
# License: The Unlicense (https://unlicense.org)
################################################################################

include(CheckCXXCompilerFlag)

add_library(compiler_settings INTERFACE)
target_compile_features(compiler_settings INTERFACE cxx_std_20)

check_cxx_compiler_flag(-Weverything HAS_COMPILER_WARNING_EVERYTHING)
if (${HAS_COMPILER_WARNING_EVERYTHING})
  target_compile_options(compiler_settings INTERFACE -Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-padded)
else()
  check_cxx_compiler_flag(-Wall HAS_COMPILER_WARNING_ALL)
  if (${HAS_COMPILER_WARNING_ALL})
    target_compile_options(compiler_settings INTERFACE -Wall)
  endif()
  check_cxx_compiler_flag(-Wextra HAS_COMPILER_WARNING_EXTRA)
  if(${HAS_COMPILER_WARNING_EXTRA})
    target_compile_options(compiler_settings INTERFACE -Wextra)
  endif()
  check_cxx_compiler_flag(-Wshadow HAS_COMPILER_WARNING_SHADOW)
  if(${HAS_COMPILER_WARNING_SHADOW})
    target_compile_options(compiler_settings INTERFACE -Wshadow)
  endif()
  check_cxx_compiler_flag(-Wnon-virtual-dtor HAS_COMPILER_WARNING_NONVIRTUAL_DTOR)
  if(${HAS_COMPILER_WARNING_NONVIRTUAL_DTOR})
    target_compile_options(compiler_settings INTERFACE -Wnon-virtual-dtor)
  endif()
  check_cxx_compiler_flag(-Wold-style-cast HAS_GCC_WOLD_STYLE_CAST)
  if(${HAS_GCC_WOLD_STYLE_CAST})
    target_compile_options(compiler_settings INTERFACE -Wold-style-cast)
  endif()
  check_cxx_compiler_flag(-Wcast-align HAS_GCC_WCAST_ALIGN)
  if(${HAS_GCC_WCAST_ALIGN})
    target_compile_options(compiler_settings INTERFACE -Wcast-align)
  endif()
  check_cxx_compiler_flag(-Wunused HAS_GCC_WUNUSED)
  if(${HAS_GCC_WUNUSED})
    target_compile_options(compiler_settings INTERFACE -Wunused)
  endif()
  check_cxx_compiler_flag(-Woverloaded-virtual HAS_GCC_WOVERLOADED_VIRTUAL)
  if(${HAS_GCC_WOVERLOADED_VIRTUAL})
    target_compile_options(compiler_settings INTERFACE -Woverloaded-virtual)
  endif()
  check_cxx_compiler_flag(-Wpedantic HAS_GCC_WPEDANTIC)
  if(${HAS_GCC_WPEDANTIC})
    target_compile_options(compiler_settings INTERFACE -Wpedantic)
  endif()
  check_cxx_compiler_flag(-Wconversion HAS_GCC_WCONVERSION)
  if(${HAS_GCC_WCONVERSION})
    target_compile_options(compiler_settings INTERFACE -Wconversion)
  endif()
  check_cxx_compiler_flag(-Wsign-conversion HAS_GCC_WSIGN_CONVERSION)
  if(${HAS_GCC_WSIGN_CONVERSION})
    target_compile_options(compiler_settings INTERFACE -Wsign-conversion)
  endif()
  check_cxx_compiler_flag(-Wmisleading-indentation HAS_GCC_WMISLEADING_INDENTATION)
  if(${HAS_GCC_WMISLEADING_INDENTATION})
    target_compile_options(compiler_settings INTERFACE -Wmisleading-indentation)
  endif()
  check_cxx_compiler_flag(-Wduplicated-cond HAS_COMPILER_WARNING_DUPLICATED_COND)
  if(${HAS_COMPILER_WARNING_DUPLICATED_COND})
    target_compile_options(compiler_settings INTERFACE -Wduplicated-cond)
  endif()
  check_cxx_compiler_flag(-Wduplicated-branches HAS_COMPILER_WARNING_DUPLICATED_BRANCHES)
  if(${HAS_COMPILER_WARNING_DUPLICATED_BRANCHES})
    target_compile_options(compiler_settings INTERFACE -Wduplicated-branches)
  endif()
  check_cxx_compiler_flag(-Wlogical-op HAS_COMPILER_WARNING_LOGICAL_OP)
  if(${HAS_COMPILER_WARNING_LOGICAL_OP})
    target_compile_options(compiler_settings INTERFACE -Wlogical-op)
  endif()
  check_cxx_compiler_flag(-Wnull-dereference HAS_COMPILER_WARNING_NULL_DEREFERENCE)
  if(${HAS_COMPILER_WARNING_NULL_DEREFERENCE})
    target_compile_options(compiler_settings INTERFACE -Wnull-dereference)
  endif()
  check_cxx_compiler_flag(-Wuseless-cast HAS_COMPILER_WARNING_USELESS_CAST)
  if(${HAS_COMPILER_WARNING_USELESS_CAST})
    target_compile_options(compiler_settings INTERFACE -Wuseless-cast)
  endif()
  check_cxx_compiler_flag(-Wdouble-promotion HAS_COMPILER_WARNING_DOUBLE_PROMOTION)
  if(${HAS_COMPILER_WARNING_DOUBLE_PROMOTION})
    target_compile_options(compiler_settings INTERFACE -Wdouble-promotion)
  endif()
  check_cxx_compiler_flag(-Wlifetime HAS_COMPILER_WARNING_LIFETIME)
  if(${HAS_COMPILER_WARNING_LIFETIME})
    target_compile_options(compiler_settings INTERFACE -Wlifetime)
  endif()
  # -Weffc++ can be difficult to please, enable at your own risk
  #check_cxx_compiler_flag(-Weffc++ HAS_COMPILER_WARNING_EFFCPLUSPLUS)
  if(${HAS_COMPILER_WARNING_EFFCPLUSPLUS})
    target_compile_options(compiler_settings INTERFACE -Weffc++)
  endif()
  check_cxx_compiler_flag(-Wsuggest-attribute=pure HAS_COMPILER_WARNING_SUGGEST_ATTRIBUTE_PURE)
  if(${HAS_COMPILER_WARNING_SUGGEST_ATTRIBUTE_PURE})
    target_compile_options(compiler_settings INTERFACE -Wsuggest-attribute=pure)
  endif()
  check_cxx_compiler_flag(-Wsuggest-attribute=const HAS_COMPILER_WARNING_SUGGEST_ATTRIBUTE_CONST)
  if(${HAS_COMPILER_WARNING_SUGGEST_ATTRIBUTE_CONST})
    target_compile_options(compiler_settings INTERFACE -Wsuggest-attribute=const)
  endif()
endif()