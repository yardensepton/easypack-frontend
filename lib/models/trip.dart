import 'package:easypack/models/city.dart';

class Trip {
  String? id;
  String userId;
  City destination;
  String departureDate;
  String returnDate;

  Trip(
      {this.id,
      required this.userId,
      required this.departureDate,
      required this.destination,
      required this.returnDate});

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
        id: json['_id'],
        userId: json['user_id'],
        destination: City.fromJson(json['destination']),
        departureDate: json['departure_date'],
        returnDate: json['return_date']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'destination': destination,
      'departure_date': departureDate,
      'return_date': returnDate
    };
  }
}
