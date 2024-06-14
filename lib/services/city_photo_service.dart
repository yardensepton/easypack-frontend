import 'package:http/http.dart' as http;

class CityPhotoService {
  Future<String> fetchPhotoResult(String input) async {
    // String apiUrl = 'http://localhost:8000/cities/picture/$input';
    String apiUrl = 'http://192.168.1.197:8000/cities/picture/$input';

    String stringResponse;

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        stringResponse = response.body;
         if (stringResponse.startsWith('"') && stringResponse.endsWith('"')) {
          stringResponse = stringResponse.substring(1, stringResponse.length - 1);
         }
      } else {
        throw Exception('Failed to fetch photo results. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching photo results: $e');
    }

    return stringResponse;
  }
}
