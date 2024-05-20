import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easypack/models/user.dart';

class UserAPIService {
  static const String apiUrl = 'http://localhost:8000/users'; 

  Future<User?> createUser(User user) async {
    final url = Uri.parse(apiUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(user.toJson());

 
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create user: ${response.body}');
      }
    } 
  }

