import 'package:easypack/exception/server_exception.dart';
import 'package:easypack/models/city.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CitySearchService {
  Future<List<City>> fetchAutocompleteResults(String input,
      {int page = 1, int size = 10}) async {
    // String apiUrl = 'http://localhost:8000/cities/city-autocomplete/$input?page=$page&size=$size';
    String apiUrl =
        'http://192.168.1.199:8000/cities/city-autocomplete/$input?page=$page&size=$size';

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedData =
            utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(decodedData) as Map<String, dynamic>;
        if (jsonResponse.containsKey('items')) {
          List<dynamic> items = jsonResponse['items'];
          List<City> results =
              items.map((json) => City.fromJson(json)).toList();
          return results;
        } else {
          throw ServerException('Invalid response format');
        }
      } else {
        throw ServerException(
            'Failed to fetch autocomplete results. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error fetching autocomplete results: $e');
    }
  }
}
