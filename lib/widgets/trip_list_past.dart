import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/small_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';

class TripListPast extends StatelessWidget {
  final String timeline;

  const TripListPast({super.key, required this.timeline});

  @override
  Widget build(BuildContext context) {
    final tripDetailsProvider =
        Provider.of<TripDetailsProvider>(context, listen: false);

    return FutureBuilder<void>(
      future: tripDetailsProvider.fetchPlannedTrips(),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return const Text("");
        } else {
          if (tripDetailsProvider.pastTrips.isEmpty) {
            return const Text("");
          }

          return Consumer<TripDetailsProvider>(
            builder: (context, tripDetailsProvider, child) {
              return SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tripDetailsProvider.pastTrips.length,
                  itemBuilder: (context, index) {
                    if (index < tripDetailsProvider.pastTrips.length) {
                      TripInfo? trip = tripDetailsProvider.pastTrips[index];
                      return SmallTripCard(trip: trip,boxKey: Timeline.past);
                    } else {
                      return const SizedBox(); // Placeholder, handle out-of-bounds index gracefully
                    }
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
