import 'package:easypack/models/city.dart';
import 'package:easypack/models/weather.dart';

class Trip {
  String? id;
  City destination;
  String departureDate;
  String returnDate;
  List<Weather>? weatherData;

  Trip({
    this.id,
    required this.departureDate,
    required this.destination,
    required this.returnDate,
    this.weatherData,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    List<Weather>? weatherList;
    if (json['weather_data'] != null) {
      weatherList = (json['weather_data'] as List)
          .map((item) => Weather.fromJson(item))
          .toList();
    }

    return Trip(
      id: json['id'],
      destination: City.fromJson(json['destination']),
      departureDate: json['departure_date'],
      returnDate: json['return_date'],
      weatherData: weatherList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? weatherList;
    if (weatherData != null) {
      weatherList = weatherData!.map((item) => item.toJson()).toList();
    }

    return {
      'id': id,
      'destination': destination.toJson(),
      'departure_date': departureDate,
      'return_date': returnDate,
      'weather_info': weatherList,
    };
  }
}
