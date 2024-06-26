class TripInfo {
  final String tripId;
  final String destination;
  final String departureDate;
  final String returnDate;
  final String cityUrl;

  TripInfo({
    required this.tripId,
    required this.destination,
    required this.departureDate,
    required this.returnDate,
    required this.cityUrl
  });

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