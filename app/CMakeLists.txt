################################################################################
# License: The Unlicense (https://unlicense.org)
################################################################################

add_executable(extract_stats)
target_compile_features(extract_stats PRIVATE cxx_std_20)
target_link_libraries(extract_stats PRIVATE compiler_settings date::date pugixml sfml-graphics Eigen3::Eigen)
target_sources(extract_stats PRIVATE extract_stats/main.cpp)
