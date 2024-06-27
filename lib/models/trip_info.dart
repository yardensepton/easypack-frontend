import 'package:hive/hive.dart';

part 'trip_info.g.dart';

@HiveType(typeId: 1)
class TripInfo {
  @HiveField(0)
  final String tripId;
  @HiveField(1)
  final String destination;
  @HiveField(2)
  final String departureDate;
  @HiveField(3)
  final String returnDate;
  @HiveField(4)
  final String cityUrl;

  TripInfo(
      {required this.tripId,
      required this.destination,
      required this.departureDate,
      required this.returnDate,
      required this.cityUrl});

  factory TripInfo.fromJson(Map<String, dynamic> json) {
    return TripInfo(
      tripId: json['trip_id'],
      destination: json['destination'],
      departureDate: json['departure_date'],
      returnDate: json['return_date'],
      cityUrl: json['city_url'],
    );
  }

  @override
  String toString() {
    return "trip tp $destination,  $departureDate - $returnDate ";
  }
}
