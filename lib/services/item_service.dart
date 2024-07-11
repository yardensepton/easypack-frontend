import 'dart:convert';

import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/services/user_service.dart';
import 'package:http/http.dart' as http;

class ItemService {
  UserService userService = UserService();
  String? token;

  Future<List<String>?> fetchItemsNamesByCategory() async {
    String? token = await userService.getAccessToken();
    final url = Uri.parse("${Urls.baseUrl}/items?category=special items");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      http.Response response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        return fromJsonReturnItemName(response);
      } else if (response.statusCode == 401) {
        await userService.refreshAccessToken();
        token = await userService.getAccessToken();
        final refreshedHeaders = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        response = await http.get(url, headers: refreshedHeaders);

        if (response.statusCode == 200) {
          return fromJsonReturnItemName(response);
        } else if (response.statusCode == 404) {
          return null;
        } else {
          throw Exception('Server error: ${response.statusCode}');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  List<String>? fromJsonReturnItemName(http.Response response) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => item['name'] as String).toList();
  }

  // Future<String?> fetchSpecielItemsNames(
  // ) async {
  //   token = await userService.getAccessToken();
  //   print("in create new trip token is $token");
  //   final url = Uri.parse("${Urls.baseUrl}/items");
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final body = json.encode(newTrip.toJson());

  //   final response = await http.get(url, headers: headers, body: body);
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = jsonDecode(response.body);
  //     print("the response is$responseData");
  //     Trip trip = Trip.fromJson(responseData);
  //     saveInHive(trip);
  //     return null;
  //   } else if (response.statusCode == 401) {
  //     await userService.refreshAccessToken();
  //     token = await userService.getAccessToken();
  //     print("in the trip service the token is $token");
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     };
  //     final response = await http.post(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = jsonDecode(response.body);
  //       Trip trip = Trip.fromJson(responseData);
  //       saveInHive(trip);
  //       return null;
  //     } else {
  //       return ServerError.getErrorMsg(jsonDecode(response.body));
  //     }
  //   } else {
  //     return ServerError.getErrorMsg(jsonDecode(response.body));
  //   }
  // }
}
