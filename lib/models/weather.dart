class Weather{
String dateTime;
double tempMax;
double tempMin;
double feelsLike;
double precipProb;
double windSpeed;
String conditions;
String icon;

  Weather({
    required this.dateTime,
    required this.tempMax,
    required this.tempMin,
    required this.feelsLike,
    required this.precipProb,
    required this.windSpeed,
    required this.conditions,
    required this.icon,
  });

  
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        dateTime: json['datetime'],
        tempMax: json['temp_max'],
        tempMin: json['temp_min'],
        feelsLike: json['feels_like'],
        precipProb: json['precip_prob'],
        windSpeed: json['wind_speed'],
        conditions: json['conditions'],
        icon: json['icon']);
  }


  Map<String, dynamic> toJson() {
    return {
      'datetime': dateTime,
      'temp_max': tempMax,
      'temp_min': tempMin,
      'feels_like': feelsLike,
      'precip_prob': precipProb,
      'wind_speed': windSpeed,
      'conditions': conditions,
      'icon': icon,

    };
  }



}