import 'package:easypack/models/city.dart';

class User {
  String name;
  String email;
  String gender;
  String password;
  String role;
  City? city;

  User({
    required this.name,
    required this.password,
    required this.email,
    required this.gender,
    required this.role,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        email: json['email'],
        gender: json['gender'],
        city: json['city'] != null ? City.fromJson(json['city']) : null,
        password: json['password'],
        role: json['role']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
       if (city != null) 'city': city!.toJson(),
      'password': password,
      'role': role
    };
  }
}
