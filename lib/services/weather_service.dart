import 'dart:convert';
import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String getWeather = '/weather';

  Future<void> fetchWeather(String location,
      {String? departure, String? arrival}) async {

    Map<String, String?> queryParams = {
      "location": location,
      "departure": departure,
      "arrival": arrival,
    };
    Uri uri = Uri.parse('${Urls.baseUrl}$getWeather').replace(queryParameters: queryParams);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        List<Weather> weatherData = results.map((json)=>Weather.fromJson(json)).toList();
        print(weatherData);
      } else {
        print('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
