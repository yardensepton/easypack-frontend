import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';

class ListWeatherDays extends StatelessWidget {
  const ListWeatherDays({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Consumer<TripDetailsProvider>(
      builder: (context, tripDetailsProvider, child) {
        return SizedBox(
          height: screenSize.height * 0.2, // Adjusted height
          width: screenSize.width,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(), // Ensure scrolling is always enabled
            scrollDirection: Axis.horizontal,
            itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
            itemBuilder: (context, index) {
              final weatherDay = tripDetailsProvider.cachedTrip?.weatherData?[index];
              return Container(
                width: screenSize.width * 0.3, // Adjusted width
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(8.0), // Reduced padding
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Smaller border radius
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      FormatDate.getformatDate(weatherDay!.dateTime),
                      style: const TextStyle(
                        fontSize: 13, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SvgPicture.asset(
                      "assets/icons/${weatherDay.icon}.svg",
                      width: screenSize.width * 0.08, // Reduced icon size
                      height: screenSize.width * 0.08,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weatherDay.conditions,
                      style: const TextStyle(
                        fontSize: 12, // Reduced font size
                        color: Color.fromARGB(255, 55, 63, 67),
                      ),
                    ),
                    const SizedBox(height: 4), // Reduced spacing
                    Text(
                      '${weatherDay.tempMin}°C - ${weatherDay.tempMax}°C',
                      style: const TextStyle(
                        fontSize: 11, // Reduced font size
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
