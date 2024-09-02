import 'package:easypack/config.dart';
import 'package:easypack/constants/constants_classes.dart';
import 'package:http/http.dart' as http;

class CityPhotoService {
  Future<String> fetchPhotoResult(String input) async {
    String apiUrl = '/cities/picture/$input';

    String stringResponse;

    try {
      http.Response response = await http.get(Uri.parse("${Config.backendUrl}$apiUrl"));

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
