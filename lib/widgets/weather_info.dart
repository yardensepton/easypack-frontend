// import 'package:easypack/providers/trip_details_provider.dart';
// import 'package:easypack/utils/format_date.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// class WeatherInfo extends StatelessWidget {
//   const WeatherInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TripDetailsProvider>(
//       builder: (context, tripDetailsProvider, child) {
//         return SizedBox(
//           height: 100,
//           child: ListView.separated(
//             physics: const BouncingScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             separatorBuilder: (context, index) => const VerticalDivider(
//               color: Colors.transparent,
//               width: 5,
//             ),
//             itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
//             itemBuilder: (context, index) {
//               final weatherDay =
//                   tripDetailsProvider.cachedTrip?.weatherData?[index];
//               return SizedBox(
//                 width: 100,
//                 height: 100,
//                 child: Card(
//                   shadowColor: Colors.black26,
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         FormatDate.getformatDate(weatherDay!.dateTime),
//                         style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black45,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 40,
//                         height: 40,
//                          child: SvgPicture.asset(
//                       "assets/icons/${weatherDay.icon}.svg",
//                     ),
//                       ),
//                        Text(
//                       '${weatherDay.tempMin.round()}°C - ${weatherDay.tempMax.round()}°C',
//                       style: const TextStyle(
//                         fontSize: 11, // Reduced font size
//                         color: Colors.grey,
//                       ),
//                     ),
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
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Note the updated import
import 'package:provider/provider.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripDetailsProvider>(
      builder: (context, tripDetailsProvider, child) {
        return SizedBox(
          height: 140,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: 10, // Increased space between cards for better shadow visibility
            ),
            itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
            itemBuilder: (context, index) {
              final weatherDay =
                  tripDetailsProvider.cachedTrip?.weatherData?[index];
              return SizedBox(
                width: 140,
                height: 140,
                child: Card(
                  shadowColor: Colors.black, // Darker shadow color
                  color: Colors.white,
                  elevation: 10.0, // Increased elevation for more noticeable shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0), // Added padding for better layout
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          FormatDate.getformatDate(weatherDay!.dateTime),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: SvgPicture.asset(
                            "assets/icons/${weatherDay.icon}.svg",
                          ),
                        ),
                        Text(
                          '${weatherDay.tempMin.round()}°C - ${weatherDay.tempMax.round()}°C',
                          style: const TextStyle(
                            fontSize: 11, // Reduced font size
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
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
