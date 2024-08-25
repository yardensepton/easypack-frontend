import 'package:easypack/models/trip_info.dart';
import 'package:easypack/pages/all_trips_list.dart';
import 'package:easypack/widgets/slide_page_route.dart';
import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  final String title;
  final List<TripInfo> trips;
  const SeeAllButton({super.key, required this.title, required this.trips});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
           _openAllTripsPage(context,trips,title);
          },
          child: Text('See all', style: TextStyle(color: Colors.indigo[900])),
        ),
      ],
    );
  }
}

void _openAllTripsPage(BuildContext context, List<TripInfo> trips, String title) {
  Navigator.of(context).push(_createRoute(trips,title));
}

Route _createRoute(List<TripInfo> trips, String title) {
  return SlidePageRoute(
    page: AllTripsList(trips: trips, title: title),
  );
}
