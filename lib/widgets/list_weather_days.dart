// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:easypack/providers/trip_details_provider.dart';

// class ListWeatherDays extends StatelessWidget {
//   const ListWeatherDays({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.sizeOf(context).width;
//     double height = MediaQuery.sizeOf(context).height;

//     return Consumer<TripDetailsProvider>(
//       builder: (context, tripDetailsProvider, child) {
//         return SizedBox(
//           height: 200,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
//             itemBuilder: (context, index) {
//               final weatherDay =
//                   tripDetailsProvider.cachedTrip?.weatherData?[index];
//               return Container(
//                 width: width*0.1,
//                 margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         weatherDay?.dateTime ?? '',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SvgPicture.asset(
//                         "assets/icons/${weatherDay?.icon}.svg",
//                         width: 60,
//                         height: 60,
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         '${weatherDay?.conditions}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 55, 63, 67),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         '${weatherDay?.tempMin ?? 0}°C - ${weatherDay?.tempMax ?? 0}°C',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
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
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:easypack/providers/trip_details_provider.dart';

// class ListWeatherDays extends StatelessWidget {
//   const ListWeatherDays({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get screen size
//     Size screenSize = MediaQuery.of(context).size;

//     return Consumer<TripDetailsProvider>(
//       builder: (context, tripDetailsProvider, child) {
//         return SizedBox(
//           height: screenSize.height*0.25,
//           width: screenSize.width, // Set width to match screen width
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
//             itemBuilder: (context, index) {
//               final weatherDay = tripDetailsProvider.cachedTrip?.weatherData?[index];
//               return Container(
//                 width: screenSize.width * 0.5, // Set container width based on screen width
//                 margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         weatherDay?.dateTime ?? '',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       SvgPicture.asset(
//                         "assets/icons/${weatherDay?.icon}.svg",
//                         width: screenSize.width * 0.1, // Adjust SVG width dynamically
//                         height: screenSize.width * 0.1, // Adjust SVG height dynamically
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         '${weatherDay?.conditions}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 55, 63, 67),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         '${weatherDay?.tempMin ?? 0}°C - ${weatherDay?.tempMax ?? 0}°C',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
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
          height: screenSize.height * 0.23,
          width: screenSize.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
            itemBuilder: (context, index) {
              final weatherDay =
                  tripDetailsProvider.cachedTrip?.weatherData?[index];
              return Container(
                width: screenSize.width * 0.5,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    SvgPicture.asset(
                      "assets/icons/${weatherDay.icon}.svg",
                      width: screenSize.width * 0.15,
                      height: screenSize.width * 0.15,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      weatherDay.conditions,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 55, 63, 67),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${weatherDay?.tempMin ?? 0}°C - ${weatherDay?.tempMax ?? 0}°C',
                      style: const TextStyle(
                        fontSize: 14,
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
