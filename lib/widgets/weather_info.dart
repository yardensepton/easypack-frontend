import 'package:easypack/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherInfo extends StatelessWidget {
  final List<Weather> weatherData;

  const WeatherInfo({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: weatherData.length,
        itemBuilder: (context, index) {
          final weatherDay = weatherData[index];
          return SizedBox(
            width: 100, // Adjust the width of each card
            child: Card(
              shadowColor: Colors.grey,
              color: Colors.white,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                 side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      FormatDate.getformatDate(weatherDay.dateTime),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        "assets/icons/${weatherDay.icon}.svg",
                      ),
                    ),
                    // SizedBox(height: 5),
                    Text(
                      '${weatherDay.tempMax.round()}°C',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${weatherDay.tempMin.round()}°C',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
