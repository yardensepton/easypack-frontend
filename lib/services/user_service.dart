import 'dart:convert';
import 'package:easypack/exception/server_error.dart';
import 'package:easypack/models/city.dart';
import 'package:http/http.dart' as http;
import 'package:easypack/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  static const String baseUrl = 'http://localhost:8000';
  // static const String baseUrl = 'http://192.168.1.197:8000';
  static const String createUserUrl = '/users/sign-up';
  static const String loginUserUrl = '/users/login';
  static const String forgotPasswordUrl = '/users/forgot-password';
  static const storage = FlutterSecureStorage();

  Future<String?> createUser(
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
      return null;
    } else {
      return ServerError.getErrorMsg(jsonDecode(response.body));
    }
  }

  Future<String?> authUser(String username, String password) async {
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
      print("in auth user service $data");
      await storage.write(key: 'access_token', value: accessToken);
      await storage.write(key: 'refresh_token', value: refreshToken);
      return null;
    }

    return ServerError.getErrorMsg(jsonDecode(response.body));
  }

  Future<String?> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl$forgotPasswordUrl?user_email=$email'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return null;
    }

    return ServerError.getErrorMsg(jsonDecode(response.body));
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refresh_token');
  }

  Future<void> logOutUser() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }

  Future<void> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    print("refresh token is: $refreshToken");
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final url = Uri.parse('$baseUrl/users/refresh?refresh_token=$refreshToken');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData);
      String accessToken = responseData['access_token'];
      await storage.write(key: 'access_token', value: accessToken);
      print("access token after change in is: $accessToken");
    } else {
      final responseBody = response.body;
      print(
          'Failed to refresh access token. Status code: ${response.statusCode}. Response: $responseBody');
      throw Exception('Failed to refresh access token');
    }
  }
}
