import 'package:easypack/exception/server_error.dart';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/trip.dart';
import 'package:easypack/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripService {
  // String apiUrl = 'http://localhost:8000/trips';
  String apiUrl = 'http://192.168.1.197:8000/trips';

  Future<String?> creatTrip({
    required City destination,
    required String departureDate,
    required String returnDate,
  }) async {
    final newTrip = Trip(
      destination: destination,
      departureDate: departureDate,
      returnDate: returnDate,
    );

    UserService userService = UserService();
    String? token = await userService.getAccessToken();
    final url = Uri.parse(apiUrl);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode(newTrip.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return null;
    } else if (response.statusCode == 401) {
      await userService.refreshAccessToken();
      token = await userService.getAccessToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return null;
      } else {
        return ServerError.getErrorMsg(jsonDecode(response.body));
      }
    } else {
      return ServerError.getErrorMsg(jsonDecode(response.body));
    }
  }


}
