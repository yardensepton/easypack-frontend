import 'dart:convert';
import 'package:easypack/models/city.dart';
import 'package:http/http.dart' as http;
import 'package:easypack/models/user.dart';

class UserAPIService {
  static const String apiUrl = 'http://localhost:8000/users';
  // static const String apiUrl = 'http://192.168.1.197:8000/users';

  Future<User?> createUser(
   {required String name,
    required String email,
    required String gender,
    required City city} 
  ) async {
    final newUser = User(
      name: name,
      email: email,
      gender: gender,
      city: city,
    );

    final url = Uri.parse(apiUrl);
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
}
