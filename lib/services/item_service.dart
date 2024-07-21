import 'dart:convert';

import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/Calculation.dart';
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

  Future<List<String>?> fetchCategories(
      {String? category, bool? activity}) async {
    String? token = await userService.getAccessToken();

    Map<String, String> queryParams = {};
    if (category != null) queryParams['category'] = category;
    if (activity != null) queryParams['activity'] = activity.toString();

    final url = Uri.parse("${Urls.baseUrl}/items/calculations")
        .replace(queryParameters: queryParams);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return fromJsonReturnCalculations(response);
      } else if (response.statusCode == 401) {
        await userService.refreshAccessToken();
        token = await userService.getAccessToken();
        final refreshedHeaders = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        response = await http.get(url, headers: refreshedHeaders);
        if(response.statusCode == 401){

        }

        if (response.statusCode == 200) {
          return fromJsonReturnCalculations(response);
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

  List<String>? fromJsonReturnCalculations(http.Response response) {
    List<dynamic> data = jsonDecode(response.body);
    print(data);
    return data.map((item) => item['category'] as String).toList();
  }

  List<String>? fromJsonReturnItemName(http.Response response) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => item['name'] as String).toList();
  }
}
