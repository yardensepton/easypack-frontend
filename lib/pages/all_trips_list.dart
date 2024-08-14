import 'package:easypack/models/trip_info.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';

class AllTripsList extends StatefulWidget {
  final List<TripInfo> trips;
  final String title;

  const AllTripsList({super.key, required this.trips,required this.title});

  @override
  _AllTripsListState createState() => _AllTripsListState();
}

class _AllTripsListState extends State<AllTripsList> {
  late List<TripInfo> filteredTrips;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredTrips = widget.trips;
  }

  void _filterTrips(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredTrips = widget.trips
          .where((trip) =>
              trip.destination.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFdfbfbfb),
      appBar: AppBar(
        title:  Text(widget.title),
        centerTitle: true,
         backgroundColor: const Color(0xFdfbfbfb),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterTrips,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTrips.length,
              itemBuilder: (context, index) {
                final trip = filteredTrips[index];
                return ListTile(
                  title: Text(trip.destination),
                  subtitle: Text(
                    '${FormatDate.getformatDate(trip.departureDate)} - ${FormatDate.getformatDate(trip.returnDate)}',
                  ),
                  onTap: () {
                    // Handle tap event here, like navigating to trip details
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
