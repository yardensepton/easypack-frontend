import 'package:easypack/exception/server_error.dart';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/trip.dart';
import 'package:easypack/services/user_service.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripService {
  // String apiUrl = 'http://localhost:8000/trips';
  String apiUrl = 'http://192.168.1.197:8000/trips';
  String currentUser = 'current-user';
  String upcomingTrip = '/upcoming-trip';
  UserService userService = UserService();
  String? token;
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

    token = await userService.getAccessToken();
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

  // Future<List<Trip>> getAllUsersTripsIn() async {
  //   // final userService = UserService();
  //   token = await userService.getAccessToken();
  //   final url = Uri.parse('$apiUrl/$currentUser');
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   try {
  //     http.Response response = await http.get(url, headers: headers);

  //     if (response.statusCode == 200) {
  //       List<Trip> trips = fromJsonToTrips(response);
  //       return trips;
  //     } else if (response.statusCode == 401) {
  //       await userService.refreshAccessToken();
  //       token = await userService.getAccessToken();
  //       final refreshedHeaders = {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       };
  //       response = await http.get(url, headers: refreshedHeaders);

  //       if (response.statusCode == 200) {
  //         List<Trip> trips = fromJsonToTrip(response);
  //         return trips;
  //       } else {
  //         throw Exception(ServerError.getErrorMsg(jsonDecode(response.body)));
  //       }
  //     } else {
  //       throw Exception(ServerError.getErrorMsg(jsonDecode(response.body)));
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  Trip fromJsonToTrip(http.Response response) {
    Map<String, dynamic> result = jsonDecode(response.body);
    Trip upcomingTrip = Trip.fromJson(result);
    return upcomingTrip;
  }

  Future<Trip?> getClosestUpcomingTrip() async {
    final url = Uri.parse('$apiUrl$upcomingTrip');
    String? token = await userService.getAccessToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return fromJsonToTrip(response);
      } else if (response.statusCode == 401) {
        await userService.refreshAccessToken();
        token = await userService.getAccessToken();
        final refreshedHeaders = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        response = await http.get(url, headers: refreshedHeaders);

        if (response.statusCode == 200) {
          return fromJsonToTrip(response);
        } else {
          throw Exception(ServerError.getErrorMsg(jsonDecode(response.body)));
        }
      } else {
        throw Exception(ServerError.getErrorMsg(jsonDecode(response.body)));
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
