import 'package:easypack/models/city.dart';

class Trip {
  City destination;
  String departureDate;
  String returnDate;

  Trip(
      {required this.departureDate,
      required this.destination,
      required this.returnDate});

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
        destination: City.fromJson(json['destination']),
        departureDate: json['departure_date'],
        returnDate: json['return_date']);
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'departure_date': departureDate,
      'return_date': returnDate
    };
  }
}
