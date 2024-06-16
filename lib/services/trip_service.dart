import 'package:easypack/models/city.dart';
import 'package:easypack/models/trip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripService {
  // String apiUrl = 'http://localhost:8000/trips/$userId';
  String apiUrl = 'http://192.168.1.197:8000/trips';

  Future<Trip?> creatTrip(
      {required City destination,
      required String departureDate,
      required String returnDate,
      required String userId}) async {
    final newTrip = Trip(
      destination: destination,
      departureDate: departureDate,
      returnDate: returnDate,
      userId: userId,
    );
    final url = Uri.parse(apiUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(newTrip.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return Trip.fromJson(json.decode(response.body));
    } else {
      final Map<String, dynamic> errorResponse = json.decode(response.body);
      throw Exception(errorResponse);
    }
  }
}
