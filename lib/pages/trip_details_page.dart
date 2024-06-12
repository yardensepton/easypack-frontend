// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class TripDetailsPage extends StatefulWidget {
//   const TripDetailsPage({super.key});

//   @override
//   _TripDetailsPageState createState() => _TripDetailsPageState();
// }

// class _TripDetailsPageState extends State<TripDetailsPage> {
//   bool hasEquipmentList = false;

//   final List<Map<String, dynamic>> weatherForecast = [
//     {'date': DateTime.now(), 'temperature': 22, 'icon': 'lib/assets/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 1)), 'temperature': 24, 'icon': 'lib/assets/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 2)), 'temperature': 19, 'icon':'lib/assets/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 3)), 'temperature': 21, 'icon': 'lib/assets/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 4)), 'temperature': 18, 'icon':'lib/assets/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 5)), 'temperature': 23, 'icon': 'lib/assets/clear-day.svg'},
//     {'date': DateTime.now().add(const Duration(days: 6)), 'temperature': 25, 'icon': 'lib/assets/clear-day.svg'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//     final String destination = 'Paris';
//     final DateTime departureDate = DateTime.now();
//     final DateTime returnDate = DateTime.now().add(const Duration(days: 7));

//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Trip to $destination',
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'From: ${dateFormat.format(departureDate)} - To: ${dateFormat.format(returnDate)}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.white70,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue[100]!, Colors.blue[50]!],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: 100,
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
//                           const SizedBox(height: 5),
//                           Icon(weather['icon'], size: 24),
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
//                         // Add action to handle equipment list
//                         setState(() {
//                           hasEquipmentList = !hasEquipmentList;
//                         });
//                       },
//                       icon: Icon(hasEquipmentList ? Icons.view_list : Icons.add),
//                       label: Text(
//                         hasEquipmentList
//                             ? 'View Equipment List'
//                             : 'Create Equipment List',
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white, backgroundColor: Colors.green,
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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({super.key});

  @override
  _TripDetailsPageState createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  bool hasEquipmentList = false;

  final List<Map<String, dynamic>> weatherForecast = [
    {'date': DateTime.now(), 'temperature': 22, 'icon': 'lib/assets/icons/wind.svg'},
    {'date': DateTime.now().add(const Duration(days: 1)), 'temperature': 24, 'icon': 'lib/assets/icons/wind.svg'},
    {'date': DateTime.now().add(const Duration(days: 2)), 'temperature': 19, 'icon': 'lib/assets/icons/partly-cloudy-day.svg'},
    {'date': DateTime.now().add(const Duration(days: 3)), 'temperature': 21, 'icon': 'lib/assets/icons/clear-day.svg'},
    {'date': DateTime.now().add(const Duration(days: 4)), 'temperature': 18, 'icon': 'lib/assets/icons/clear-day.svg'},
    {'date': DateTime.now().add(const Duration(days: 5)), 'temperature': 23, 'icon': 'lib/assets/icons/clear-day.svg'},
    {'date': DateTime.now().add(const Duration(days: 6)), 'temperature': 25, 'icon': 'lib/assets/icons/clear-day.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final String destination = 'Paris';
    final DateTime departureDate = DateTime.now();
    final DateTime returnDate = DateTime.now().add(const Duration(days: 7));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip to $destination',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'From: ${dateFormat.format(departureDate)} - To: ${dateFormat.format(returnDate)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weatherForecast.length,
                itemBuilder: (context, index) {
                  final weather = weatherForecast[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateFormat.format(weather['date']),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 7),
                          SvgPicture.asset(
                            weather['icon'],
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${weather['temperature']}°C',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
                      'Enjoy your trip to $destination!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add action to handle equipment list
                        setState(() {
                          hasEquipmentList = !hasEquipmentList;
                        });
                      },
                      icon: Icon(hasEquipmentList ? Icons.view_list : Icons.add),
                      label: Text(
                        hasEquipmentList
                            ? 'View Equipment List'
                            : 'Create Equipment List',
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
