class City {
  final String placeId;
  final String cityName;
  final String photoUrl ='';

  City({
    required this.placeId,
    required this.cityName,
  });

   factory City.fromJson(Map<String, dynamic> json) {
    return City(
      placeId: json['place_id'],
      cityName: json['city_name'],
    );
  }
}