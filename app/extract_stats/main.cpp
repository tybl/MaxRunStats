// License: The Unlicense (https://unlicense.org)

#include "date/date.h"
#include "pugixml.hpp"

#include <Eigen/Dense>
#include <SFML/Graphics.hpp>

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

std::vector<Eigen::Vector2d> ReadFile(std::string const& filename) {
  std::vector<Eigen::Vector2d> result;
  pugi::xml_document doc;
  if (!doc.load_file(filename.c_str())) return result;
  auto const& activities = doc.child("TrainingCenterDatabase").child("Activities");

  for (auto const& activity : activities.children("Activity")) {
    auto activity_start_time = std::chrono::system_clock::now();
    for (auto const& lap : activity.children("Lap")) {
      auto lap_start_time = ParseTime(lap.attribute("StartTime").as_string());
      activity_start_time = std::min(activity_start_time, lap_start_time);
      auto const& track = lap.child("Track");
      for (auto const& track_point : track.children("Trackpoint")) {
        auto distance = track_point.child("DistanceMeters").text().as_double();
        std::chrono::duration<double> elapsed_time = ParseTime(track_point.child("Time").child_value()) - activity_start_time;
        result.emplace_back(distance, elapsed_time.count());
      }
    }
  }
  return result;
}

void TransformData(std::vector<Eigen::Vector2d>& data) {
  // Get min/max x/y
  double min_x = 0;
  double min_y = 0;
  double max_x = 0;
  double max_y = 0;
  for (auto const& v : data) {
    min_x = std::min(min_x, v(0));
    min_y = std::min(min_y, v(1));
    max_x = std::max(max_x, v(0));
    max_y = std::max(max_y, v(1));
  }
  Eigen::Matrix2d rot;
  //rot << 
}

// Open window
// read data
// find min/max x and y
// transform data
// draw data

int main(int argc, char const* argv[]) {
    // create the window
    sf::RenderWindow window(sf::VideoMode(800, 600), "My window");

    // run the program as long as the window is open
    while (window.isOpen()) {
        // check all the window's events that were triggered since the last iteration of the loop
        sf::Event event;
        while (window.pollEvent(event)) {
            // "close requested" event: we close the window
            if (event.type == sf::Event::Closed) window.close();
        }

        // clear the window with black color
        window.clear(sf::Color::Black);

        // draw everything here...
        // window.draw(...);

        // end the current frame
        window.display();
    }

    return 0;
}

#if 0
auto main(int argc, char const* argv[]) -> int {
  std::vector<sf::Vertex> line;
  std::cout << std::fixed << std::setprecision(1);
  std::map<int, std::map<int, std::chrono::duration<double>>> table;
  for (int i = 1; i < argc; ++i) {
    pugi::xml_document doc;
    if (!doc.load_file(argv[i])) continue;
    auto const& activities = doc.child("TrainingCenterDatabase").child("Activities");

    for (auto const& activity : activities.children("Activity")) {
      auto activity_start_time = std::chrono::system_clock::now();
      for (auto const& lap : activity.children("Lap")) {
        auto lap_start_time = ParseTime(lap.attribute("StartTime").as_string());
        activity_start_time = std::min(activity_start_time, lap_start_time);
        auto const& track = lap.child("Track");
        for (auto const& track_point : track.children("Trackpoint")) {
          int distance = track_point.child("DistanceMeters").text().as_int();
          std::chrono::duration<double> elapsed_time = ParseTime(track_point.child("Time").child_value()) - activity_start_time;
          line.emplace_back(sf::Vector2f(distance, elapsed_time.count()));
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
#endif
