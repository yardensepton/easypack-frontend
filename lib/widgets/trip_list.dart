import 'package:easypack/models/trip_info.dart';
import 'package:easypack/widgets/small_trip_card.dart';
import 'package:flutter/material.dart';

class TripList extends StatelessWidget {
  final List<TripInfo> trips;
  final String timeline;

  const TripList({super.key, required this.trips, required this.timeline});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trips.length,
        itemBuilder: (context, index) {
          if (index < trips.length) {
            TripInfo? trip = trips[index];
            return SmallTripCard(trip: trip, boxKey: timeline);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
