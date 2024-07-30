import 'dart:convert';

import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/enums/enum_actions.dart';
import 'package:easypack/exception/server_error.dart';
import 'package:easypack/models/item_list.dart';
import 'package:easypack/models/packing_list.dart';
import 'package:easypack/models/packing_list_update.dart';
import 'package:easypack/services/user_service.dart';
import 'package:http/http.dart' as http;

class PackingListService {
  String? token;

  Future<String?> createPackingList(
      {required String tripId,
      List<String>? items,
      List<String>? activities}) async {
    token = await UserService.getAccessToken();
    final url = Uri.parse("${Urls.baseUrl}/packing-lists/$tripId");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final Map<String, dynamic> bodyMap = {};

    // Conditionally add items_preferences and activities_preferences
    if (items != null) {
      bodyMap['items_preferences'] = items;
      print(items);
    }
    if (activities != null) {
      bodyMap['activities_preferences'] = activities;
      print(activities);
    }

    // Encode the body map to a JSON string
    final body = jsonEncode(bodyMap);

    try {
      final response = await http.post(url, headers: headers, body: body);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      if (response.statusCode == 400) {
        return ServerError.getErrorMsg(responseData);
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        return null;
      } else if (response.statusCode == 401) {
        await UserService.refreshAccessToken();
        token = await UserService.getAccessToken();
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        final response = await http.post(url, headers: headers, body: body);

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
    token = await UserService.getAccessToken();
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
        await UserService.refreshAccessToken();
        token = await UserService.getAccessToken();
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

  Future<String?> deletePackingListById(
      {required String tripId, required String packingListId}) async {
    String? token = await UserService.getAccessToken();
    final url =
        Uri.parse('${Urls.baseUrl}/packing-lists/$tripId/$packingListId');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        return null;
      } else if (response.statusCode == 401) {
        await UserService.refreshAccessToken();
        token = await UserService.getAccessToken();
        final refreshedHeaders = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        response = await http.delete(url, headers: refreshedHeaders);

        if (response.statusCode == 200) {
          return null;
        } else {
          return ServerError.getErrorMsg(jsonDecode(response.body));
        }
      } else {
        return ServerError.getErrorMsg(jsonDecode(response.body));
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<PackingList?> updatePackingListById(
    {required String tripId,
    required String packingListId,
    required EnumActions action,
    required ItemList details}) async {
  print("In service - updatePackingListById");

  String? token = await UserService.getAccessToken();
  final url = Uri.parse('${Urls.baseUrl}/packing-lists/$tripId/$packingListId');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  PackingListUpdate update = PackingListUpdate(action: action, details: details);
  final body = jsonEncode(update.toJson());

  print('URL: $url');
  print('Headers: $headers');
  print('Body: $body');

  try {
    http.Response response = await http.put(url, headers: headers, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return fromJsonToPackingList(response);
    } else if (response.statusCode == 401) {
      await UserService.refreshAccessToken();
      token = await UserService.getAccessToken();
      final refreshedHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      response = await http.put(url, headers: refreshedHeaders, body: body);

      if (response.statusCode == 200) {
        return fromJsonToPackingList(response);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
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
