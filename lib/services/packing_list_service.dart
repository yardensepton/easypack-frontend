import 'dart:convert';

import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/exception/server_error.dart';
import 'package:easypack/models/packing_list.dart';
import 'package:easypack/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PackingListService {
  UserService userService = UserService();
  String? token;

  Future<String?> createPackingList({required String tripId}) async {
    token = await userService.getAccessToken();
    final url = Uri.parse("${Urls.baseUrl}/packing-lists/$tripId");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(url, headers: headers);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 400) {
        return ServerError.getErrorMsg(responseData);
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        return null;
      } else if (response.statusCode == 401) {
        await userService.refreshAccessToken();
        token = await userService.getAccessToken();
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        final response = await http.post(url, headers: headers);

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          print(responseData);
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

  Future<PackingList?> getPackingList({required String tripId}) async {
    token = await userService.getAccessToken();
    final url = Uri.parse("${Urls.baseUrl}/packing-lists?trip_id=$tripId");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 400) {
        return null;
      }
      if (response.statusCode == 200) {
        return fromJsonToPackingList(response);
      } else if (response.statusCode == 401) {
        await userService.refreshAccessToken();
        token = await userService.getAccessToken();
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        final response = await http.post(url, headers: headers);

        if (response.statusCode == 200) {
          return fromJsonToPackingList(response);
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

  PackingList fromJsonToPackingList(http.Response response) {
    Map<String, dynamic> result = jsonDecode(response.body);
    PackingList packingList = PackingList.fromJson(result);
    print(packingList);
    return packingList;
  }
}
