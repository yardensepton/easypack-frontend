import 'package:easypack/models/city.dart';

class UserUpdate {
  String? name;
  String? gender;
  City? city;

  UserUpdate({
    this.name,
    this.gender,
    this.city,
  });

  factory UserUpdate.fromJson(Map<String, dynamic> json) {
    return UserUpdate(
        name: json['name'],
        gender: json['gender'],
        city: json['city'] != null ? City.fromJson(json['city']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      if (city != null) 'city': city!.toJson(),
    };
  }
}
