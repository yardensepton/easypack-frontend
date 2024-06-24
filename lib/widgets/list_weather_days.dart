// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:easypack/providers/trip_details_provider.dart';

// class ListWeatherDays extends StatelessWidget {
//   const ListWeatherDays({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TripDetailsProvider>(
//       builder: (context, tripDetailsProvider, child) {
//         return SizedBox(
//           height: 150,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
//             itemBuilder: (context, index) {
//               final weatherDay = tripDetailsProvider.cachedTrip?.weatherData?[index];
//               return Card(
//                 color: Colors.blueGrey,
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         weatherDay?.dateTime ?? '',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 7),
//                       SvgPicture.asset(
//                         "lib/assets/icons/${weatherDay?.icon}.svg",
//                         width: 45,
//                         height: 45,
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         '${weatherDay?.feelsLike ?? 0}°C',
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';

class ListWeatherDays extends StatelessWidget {
  const ListWeatherDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripDetailsProvider>(
      builder: (context, tripDetailsProvider, child) {
        return SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
            itemBuilder: (context, index) {
              final weatherDay = tripDetailsProvider.cachedTrip?.weatherData?[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weatherDay?.dateTime ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SvgPicture.asset(
                        "lib/assets/icons/${weatherDay?.icon}.svg",
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${weatherDay?.feelsLike ?? 0}°C',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
