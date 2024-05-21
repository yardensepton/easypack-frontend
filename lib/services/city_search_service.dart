import 'package:easypack/models/city.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CitySearchService {
  Future<List<City>> fetchAutocompleteResults(String input) async {
    // String apiUrl = 'http://localhost:8000/cities/city-autocomplete/$input';
    String apiUrl = 'http://192.168.1.197:8000/cities/city-autocomplete/$input';

    List<City> results = [];

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        results = jsonResponse.map((json) => City.fromJson(json)).toList();

      } else {
        throw Exception('Failed to fetch autocomplete results. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching autocomplete results: $e');
    }

    return results;
  }
}
