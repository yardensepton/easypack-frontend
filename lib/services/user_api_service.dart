import 'dart:convert';
import 'package:easypack/models/city.dart';
import 'package:http/http.dart' as http;
import 'package:easypack/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserAPIService {
  static const String baseUrl = 'http://localhost:8000/users';
  // static const String apiUrl = 'http://192.168.1.197:8000/users';
  static const String createUserUrl = '/sign-up';
  static const String loginUserUrl = '/login';
  static const storage = FlutterSecureStorage();

  Future<User?> createUser(
      {required String name,
      required String email,
      required String gender,
      required String password,
      required String role,
      required City city}) async {
    final newUser = User(
        role: role,
        name: name,
        email: email,
        password: password,
        gender: gender,
        city: city);

    final url = Uri.parse('$baseUrl$createUserUrl');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(newUser.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      final Map<String, dynamic> errorResponse = json.decode(response.body);
      throw Exception(errorResponse);
    }
  }

  Future<String> authUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl$loginUserUrl'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String accessToken = data['access_token'];
      String refreshToken = data['refresh_token'];
      if (accessToken.isEmpty || refreshToken.isEmpty) {
        throw Exception("Access token or refresh token is empty");
      }
      await storage.write(key: 'access_token', value: accessToken);
      await storage.write(key: 'refresh_token', value: refreshToken);
      return "authenticated";
    }

    Map<String, dynamic> errorData = jsonDecode(response.body);
    // final errorMessage = json.decode(
    //     response.body); // Assuming the error message is in a 'message' field
    print(errorData['detail'] ?? '');
    return errorData['detail'] ?? '';
    // throw Exception("Failed to authenticate: $errorMessage");
  }

  // Future<String> authUser(String username, String password) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl$loginUserUrl'),
  //       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //       body: {
  //         'username': username,
  //         'password': password,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       String accessToken = data['access_token'];
  //       String refreshToken = data['refresh_token'];
  //       if (accessToken.isEmpty || refreshToken.isEmpty) {
  //         throw Exception("Something is wrong...");
  //       }
  //       await storage.write(key: 'access_token', value: accessToken);
  //       await storage.write(key: 'refresh_token', value: refreshToken);
  //       return "user created";
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  //    throw Exception("Something is wrong...");
  // }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refresh_token');
  }

  Future<void> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      body: {'refresh_token': refreshToken},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      await storage.write(
          key: 'access_token', value: responseData['access_token']);
    } else {
      throw Exception('Failed to refresh access token');
    }
  }
}
