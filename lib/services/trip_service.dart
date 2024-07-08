import 'dart:async';

import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/exception/server_error.dart';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/trip.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/services/user_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TripService {
  // String apiUrl = 'http://localhost:8000/trips';
  String apiUrl = 'http://192.168.1.199:8000/trips';
  String upcomingTrip = '/upcoming-trip';
  UserService userService = UserService();
  Box<TripInfo> tripsBox = Hive.box(Boxes.tripsBox);
  Timer? timer;
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
    print("in create new trip token is $token");
    final url = Uri.parse(apiUrl);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode(newTrip.toJson());

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print("the response is$responseData");
      Trip trip = Trip.fromJson(responseData);
      saveInHive(trip);
      return null;
    } else if (response.statusCode == 401) {
      await userService.refreshAccessToken();
      token = await userService.getAccessToken();
      print("in the trip service the token is $token");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        Trip trip = Trip.fromJson(responseData);
        saveInHive(trip);
        return null;
      } else {
        return ServerError.getErrorMsg(jsonDecode(response.body));
      }
    } else {
      return ServerError.getErrorMsg(jsonDecode(response.body));
    }
  }

  void saveInHive(Trip trip) async {
    print("${trip.id} trying to add trip to box");
    TripInfo tripInfo = TripInfo(
        tripId: trip.id!,
        destination: trip.destination.text,
        departureDate: trip.departureDate,
        returnDate: trip.returnDate,
        cityUrl: trip.destination.cityUrl!);
    print(tripInfo);
    await tripsBox.put(trip.id, tripInfo);
  }

  Trip fromJsonToTrip(http.Response response) {
    Map<String, dynamic> result = jsonDecode(response.body);
    Trip trip = Trip.fromJson(result);
    return trip;
  }

  Future<Trip?> getTripById(String tripId) async {
    String? token = await userService.getAccessToken();
    final url = Uri.parse('$apiUrl?trip_id=$tripId');

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
        } else if (response.statusCode == 404) {
          return null;
        } else {
          throw Exception(ServerError.getErrorMsg(jsonDecode(response.body)));
        }
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return null;
  }

  Future<String?> deleteTripById(String tripId) async {
    String? token = await userService.getAccessToken();
    final url = Uri.parse('$apiUrl/$tripId');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        return null;
      } else if (response.statusCode == 401) {
        await userService.refreshAccessToken();
        token = await userService.getAccessToken();
        final refreshedHeaders = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        response = await http.delete(url, headers: refreshedHeaders);

        if (response.statusCode == 200) {
          return null;
        } else {
          throw Exception(ServerError.getErrorMsg(jsonDecode(response.body)));
        }
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return null;
  }

  Future<List<TripInfo>?> getPlannedTripsInfo() async {
    final url = Uri.parse('$apiUrl/sorted');
    String? token = await userService.getAccessToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => TripInfo.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        await userService.refreshAccessToken();
        token = await userService.getAccessToken();
        final refreshedHeaders = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        response = await http.get(url, headers: refreshedHeaders);

        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData.map((json) => TripInfo.fromJson(json)).toList();
        } else if (response.statusCode == 404) {
          return null;
        }
      } else {
        throw Exception(ServerError.getErrorMsg(jsonDecode(response.body)));
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return null;
  }
}
