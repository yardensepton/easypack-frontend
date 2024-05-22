import 'package:easypack/pages/trip_details_page.dart';
import 'package:flutter/material.dart';

class TripsListPage extends StatelessWidget {
  final List<Map<String, dynamic>> trips = [
    {
      'name': 'Paris',
      'dates': '2023-05-01 to 2023-05-07',
      'icon': Icons.flight_takeoff,
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'New York',
      'dates': '2023-06-15 to 2023-06-20',
      'icon': Icons.location_city,
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Tokyo',
      'dates': '2023-07-10 to 2023-07-17',
      'icon': Icons.landscape,
      'image': 'https://via.placeholder.com/150'
    },
  ];

  TripsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripDetailsPage(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      trip['image'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(trip['icon'], color: Colors.teal),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              trip['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              trip['dates'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
