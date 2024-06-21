// import 'package:easypack/providers/auto_complete_provider.dart';
// import 'package:easypack/providers/trip_details_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class TripDetailsPage extends StatefulWidget {
//   const TripDetailsPage({super.key});

//   @override
//   _TripDetailsPageState createState() => _TripDetailsPageState();
// }

// class _TripDetailsPageState extends State<TripDetailsPage> {
//   bool hasEquipmentList = false;

//   final List<Map<String, dynamic>> weatherForecast = [
//     {'date': DateTime.now(), 'temperature': 22, 'icon': 'lib/assets/icons/wind.svg'},
//     {'date': DateTime.now().add(const Duration(days: 1)), 'temperature': 24, 'icon': 'lib/assets/icons/wind.svg'},
//     {'date': DateTime.now().add(const Duration(days: 2)), 'temperature': 19, 'icon': 'lib/assets/icons/partly-cloudy-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 3)), 'temperature': 21, 'icon': 'lib/assets/icons/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 4)), 'temperature': 18, 'icon': 'lib/assets/icons/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 5)), 'temperature': 23, 'icon': 'lib/assets/icons/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 6)), 'temperature': 25, 'icon': 'lib/assets/icons/clear-day.svg'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//     const String destination = 'Paris';
//     final DateTime departureDate = DateTime.now();
//     final DateTime returnDate = DateTime.now().add(const Duration(days: 7));

//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Trip to $destination',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'From: ${dateFormat.format(departureDate)} - To: ${dateFormat.format(returnDate)}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Color.fromARGB(255, 87, 83, 83),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 150,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: weatherForecast.length,
//                 itemBuilder: (context, index) {
//                   final weather = weatherForecast[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             dateFormat.format(weather['date']),
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 7),
//                           SvgPicture.asset(
//                             weather['icon'],
//                             width: 40,
//                             height: 40,
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             '${weather['temperature']}°C',
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Details of the Trip',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Enjoy your trip to $destination!',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       onPressed: () {

//                         // setState(() {
//                         //   hasEquipmentList = !hasEquipmentList;
//                         // });
//                       },
//                       icon: Icon(hasEquipmentList ? Icons.view_list : Icons.add),
//                       label: Text(
//                         hasEquipmentList
//                             ? 'View Equipment List'
//                             : 'Create Equipment List',
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                         textStyle: const TextStyle(fontSize: 18),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:easypack/providers/trip_details_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class TripDetailsPage extends StatefulWidget {
//   const TripDetailsPage({Key? key}) : super(key: key);

//   @override
//   _TripDetailsPageState createState() => _TripDetailsPageState();
// }

// class _TripDetailsPageState extends State<TripDetailsPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Call fetchUpcomingTrip when the page is loaded
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<TripDetailsProvider>(context, listen: false).fetchUpcomingTrip();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

//     return Scaffold(
//       appBar: AppBar(
//         title: Consumer<TripDetailsProvider>(
//           builder: (context, tripDetailsProvider, _) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Trip to ${tripDetailsProvider.destinationName.text}',
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'From: ${tripDetailsProvider.startDateController.text} - To: ${tripDetailsProvider.endDateController.text}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color.fromARGB(255, 87, 83, 83),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//       body: Consumer<TripDetailsProvider>(
//         builder: (context, tripDetailsProvider, _) {
//           if (tripDetailsProvider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return Container(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: <Widget>[
//                   // SizedBox(
//                   //   height: 150,
//                   //   child: ListView.builder(
//                   //     scrollDirection: Axis.horizontal,
//                   //     itemCount: tripDetailsProvider.weatherForecast.length,
//                   //     itemBuilder: (context, index) {
//                   //       final weather = tripDetailsProvider.weatherForecast[index];
//                   //       return Card(
//                   //         margin: const EdgeInsets.symmetric(horizontal: 8),
//                   //         child: Padding(
//                   //           padding: const EdgeInsets.all(8.0),
//                   //           child: Column(
//                   //             mainAxisAlignment: MainAxisAlignment.center,
//                   //             children: [
//                   //               Text(
//                   //                 dateFormat.format(weather['date']),
//                   //                 style: const TextStyle(
//                   //                   fontSize: 14,
//                   //                   fontWeight: FontWeight.bold,
//                   //                 ),
//                   //               ),
//                   //               const SizedBox(height: 7),
//                   //               SvgPicture.asset(
//                   //                 weather['icon'],
//                   //                 width: 40,
//                   //                 height: 40,
//                   //               ),
//                   //               const SizedBox(height: 5),
//                   //               Text(
//                   //                 '${weather['temperature']}°C',
//                   //                 style: const TextStyle(fontSize: 14),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //       );
//                   //     },
//                   //   ),
//                   // ),
//                   const SizedBox(height: 20),
//                   Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           const Text(
//                             'Details of the Trip',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             'Enjoy your trip to ${tripDetailsProvider.destinationName.text}!',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               color: Color.fromARGB(255, 64, 61, 61),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               // Implement action
//                             },
//                             icon: const Icon(Icons.add),
//                             label: const Text('Create Equipment List'),
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.white,
//                               backgroundColor: Colors.green,
//                               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                               textStyle: const TextStyle(fontSize: 18),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
// import 'dart:ui';

// import 'package:easypack/providers/trip_details_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class TripDetailsPage extends StatefulWidget {
//   const TripDetailsPage({Key? key}) : super(key: key);

//   @override
//   _TripDetailsPageState createState() => _TripDetailsPageState();
// }

// class _TripDetailsPageState extends State<TripDetailsPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Call fetchUpcomingTrip when the page is loaded
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<TripDetailsProvider>(context, listen: false).fetchUpcomingTrip();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(

//         title: Consumer<TripDetailsProvider>(
//           builder: (context, tripDetailsProvider, child) {

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                     Stack(
//           children: [
//             if(tripDetailsProvider.cachedDestinationUrl!=null)
//             SizedBox(
//               width: 400,
//               height: 400,
//               child: Image.network(
//                 tripDetailsProvider.cachedDestinationUrl!,
//               // your image url goes here
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 200.0,),
//                 Text(
//                   'Trip to ${tripDetailsProvider.destinationName.text}',
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'From: ${tripDetailsProvider.startDateController.text} - To: ${tripDetailsProvider.endDateController.text}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color.fromARGB(255, 87, 83, 83),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               Provider.of<TripDetailsProvider>(context, listen: false).fetchUpcomingTrip(forceRefresh: true);
//             },
//           ),
//         ],
//       ),
//       body: Consumer<TripDetailsProvider>(
//         builder: (context, tripDetailsProvider, _) {
//           if (tripDetailsProvider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return Container(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: <Widget>[
//                   // SizedBox(
//                   //   height: 150,
//                   //   child: ListView.builder(
//                   //     scrollDirection: Axis.horizontal,
//                   //     itemCount: tripDetailsProvider.weatherForecast.length,
//                   //     itemBuilder: (context, index) {
//                   //       final weather = tripDetailsProvider.weatherForecast[index];
//                   //       return Card(
//                   //         margin: const EdgeInsets.symmetric(horizontal: 8),
//                   //         child: Padding(
//                   //           padding: const EdgeInsets.all(8.0),
//                   //           child: Column(
//                   //             mainAxisAlignment: MainAxisAlignment.center,
//                   //             children: [
//                   //               Text(
//                   //                 dateFormat.format(weather['date']),
//                   //                 style: const TextStyle(
//                   //                   fontSize: 14,
//                   //                   fontWeight: FontWeight.bold,
//                   //                 ),
//                   //               ),
//                   //               const SizedBox(height: 7),
//                   //               SvgPicture.asset(
//                   //                 weather['icon'],
//                   //                 width: 40,
//                   //                 height: 40,
//                   //               ),
//                   //               const SizedBox(height: 5),
//                   //               Text(
//                   //                 '${weather['temperature']}°C',
//                   //                 style: const TextStyle(fontSize: 14),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //       );
//                   //     },
//                   //   ),
//                   // ),
//                   const SizedBox(height: 300.0),
//                   Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           const Text(
//                             'Details of the Trip',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             'Enjoy your trip to ${tripDetailsProvider.destinationName.text}!',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               color: Color.fromARGB(255, 39, 37, 37),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               // Implement action
//                             },
//                             icon: const Icon(Icons.add),
//                             label: const Text('Create Equipment List'),
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.white,
//                               backgroundColor: Colors.green,
//                               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                               textStyle: const TextStyle(fontSize: 18),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:easypack/providers/trip_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({Key? key}) : super(key: key);

  @override
  _TripDetailsPageState createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Call fetchUpcomingTrip when the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripDetailsProvider>(context, listen: false)
          .fetchUpcomingTrip();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TripDetailsProvider>(
        builder: (context, tripDetailsProvider, child) {
          if (tripDetailsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 400, // Adjust this height as per your needs
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (tripDetailsProvider.cachedDestinationUrl != null)
                          Image.network(
                            tripDetailsProvider.cachedDestinationUrl!,
                            fit: BoxFit.cover,
                          ),
                        Positioned(
                          top: 16,
                          left: 16,
                          right: 16,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.black.withOpacity(0.2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trip to ${tripDetailsProvider.destinationName.text}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'From: ${tripDetailsProvider.startDateController.text} - To: ${tripDetailsProvider.endDateController.text}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Details of the Trip',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Enjoy your trip to ${tripDetailsProvider.destinationName.text}!',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 39, 37, 37),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement action
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Create Equipment List'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                         IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      Provider.of<TripDetailsProvider>(context, listen: false)
                          .fetchUpcomingTrip(forceRefresh: true);
                    },
                  ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
