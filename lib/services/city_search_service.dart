import 'package:easypack/exception/server_exception.dart';
import 'package:easypack/models/city.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CitySearchService {
  Future<List<City>> fetchAutocompleteResults(String input) async {
    String apiUrl = 'http://localhost:8000/cities/city-autocomplete/$input';
    // String apiUrl = 'http://192.168.1.197:8000/cities/city-autocomplete/$input';

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<City> results =
            jsonResponse.map((json) => City.fromJson(json)).toList();
        return results;
      } else {
        throw ServerException(
            'Failed to fetch autocomplete results. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error fetching autocomplete results: $e');
    }
  }
}
