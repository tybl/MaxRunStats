// License: The Unlicense (https://unlicense.org)

#include "date/date.h"
#include "pugixml.hpp"

#include <chrono>
#include <iomanip>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <vector>

std::chrono::system_clock::time_point ParseTime(std::string const& str_time) {
  std::chrono::system_clock::time_point dt;
  std::stringstream ss(str_time);
  ss >> date::parse("%FT%T", dt);
  return dt;
}

auto main(int argc, char const* argv[]) -> int {
  std::cout << std::fixed << std::setprecision(1);
  std::map<int, std::map<int, std::chrono::duration<double>>> table;
  for (int i = 1; i < argc; ++i) {
    pugi::xml_document doc;
    if (!doc.load_file(argv[i])) {
      continue;
    }
    auto const& activities = doc.child("TrainingCenterDatabase").child("Activities");

    for (auto const& activity : activities.children("Activity")) {
      auto activity_start_time = std::chrono::system_clock::now();
      for (auto const& lap : activity.children("Lap")) {
        auto lap_start_time = ParseTime(lap.attribute("StartTime").as_string());
        activity_start_time = std::min(activity_start_time, lap_start_time);
        auto const& track = lap.child("Track");
        for (auto const& track_point : track.children("Trackpoint")) {
          int distance = track_point.child("DistanceMeters").text().as_int();
          std::chrono::duration<double> elapsed_time =
              ParseTime(track_point.child("Time").child_value()) - activity_start_time;
          table[distance][i] = elapsed_time;
        }
      }
    }
    std::cout.flush();
  }
  for (auto const& row : table) {
    std::cout << row.first;
    for (int j = 1; j < argc; ++j) {
      std::cout << ',';
      if (row.second.contains(j)) {
        std::cout << row.second.at(j).count();
      }
    }
    std::cout << '\n';
  }
}
