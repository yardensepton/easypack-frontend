class City {
  final String text;
  final String placeId;
  final String cityName;
  final String countryName;
  String cityUrl ='';
  

  City({
    required this.text,
    required this.placeId,
    required this.cityName,
    required this.countryName
  });

   factory City.fromJson(Map<String, dynamic> json) {
    return City(
      text:json['text'],
      placeId: json['place_id'],
      cityName: json['city_name'],
      countryName: json['country_name']
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'text': text,
      'city_name': cityName,
      'place_id': placeId,
      'city_url':cityUrl,
      'country_name':countryName
    };
  }
}