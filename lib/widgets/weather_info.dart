// import 'package:easypack/providers/trip_details_provider.dart';
// import 'package:easypack/utils/format_date.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; 
// import 'package:provider/provider.dart';

// class WeatherInfo extends StatelessWidget {
  
//   const WeatherInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TripDetailsProvider>(
//       builder: (context, tripDetailsProvider, child) {
//         return SizedBox(
//           height: 140,
//           child: ListView.separated(
//             physics: const BouncingScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             separatorBuilder: (context, index) => const VerticalDivider(
//               color: Colors.transparent,
//               width: 10, 
//             ),
//             itemCount: tripDetailsProvider.cachedTrip?.weatherData?.length ?? 0,
//             itemBuilder: (context, index) {
//               final weatherDay =
//                   tripDetailsProvider.cachedTrip?.weatherData?[index];
//               return SizedBox(
//                 width: 140,
//                 height: 140,
//                 child: Card(
//                   shadowColor: Colors.black,
//                   color: Colors.white,
//                   elevation: 10.0, 
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           FormatDate.getformatDate(weatherDay!.dateTime),
//                           style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black45,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 70,
//                           height: 70,
//                           child: SvgPicture.asset(
//                             "assets/icons/${weatherDay.icon}.svg",
//                           ),
//                         ),
//                         Text(
//                           '${weatherDay.tempMin.round()}°C - ${weatherDay.tempMax.round()}°C',
//                           style: const TextStyle(
//                             fontSize: 11, // Reduced font size
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
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
import 'package:easypack/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherInfo extends StatelessWidget {
  final List<Weather> weatherData;

  const WeatherInfo({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Colors.transparent,
          width: 10,
        ),
        itemCount: weatherData.length,
        itemBuilder: (context, index) {
          final weatherDay = weatherData[index];
          return SizedBox(
            width: 140,
            height: 140,
            child: Card(
              shadowColor: Colors.black,
              color: Colors.white,
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      FormatDate.getformatDate(weatherDay.dateTime),
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
                        fontSize: 11,
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
  }
}
