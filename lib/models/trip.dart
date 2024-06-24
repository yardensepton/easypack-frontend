import 'package:easypack/models/city.dart';
import 'package:easypack/models/weather.dart';

class Trip {
  City destination;
  String departureDate;
  String returnDate;
  List<Weather>? weatherData;

  Trip(
      {required this.departureDate,
      required this.destination,
      required this.returnDate,
      this.weatherData});

  factory Trip.fromJson(Map<String, dynamic> json) {
    List<Weather>? weatherList;
    if (json['weather_data'] != null) {
      weatherList = (json['weather_data'] as List)
          .map((item) => Weather.fromJson(item))
          .toList();
    }

    return Trip(
      destination: City.fromJson(json['destination']),
      departureDate: json['departure_date'],
      returnDate: json['return_date'],
      weatherData: weatherList, // Assign the parsed weather list
    );
  }

  // factory Trip.fromJson(Map<String, dynamic> json) {
  //   return Trip(
  //       destination: City.fromJson(json['destination']),
  //       departureDate: json['departure_date'],
  //       returnDate: json['return_date']);
  // }

  Map<String, dynamic> toJson() {
    // Convert weather info to JSON
    List<Map<String, dynamic>>? weatherList;
    if (weatherData != null) {
      weatherList = weatherData!.map((item) => item.toJson()).toList();
    }

    return {
      'destination': destination.toJson(),
      'departure_date': departureDate,
      'return_date': returnDate,
      'weather_info': weatherList,  // Include the weather info in the JSON map
    };
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'destination': destination,
  //     'departure_date': departureDate,
  //     'return_date': returnDate
  //   };
  // }
}
