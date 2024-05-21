import 'package:easypack/models/city.dart';

class User {
  String? id;
  String name;
  String email;
  String gender;
  City city;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.city,
  });

factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      city: City.fromJson(json['city']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'city': city,
    };
  }


  
}
