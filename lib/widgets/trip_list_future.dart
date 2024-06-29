import 'package:easypack/models/trip_info.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';

class TripListFuture extends StatefulWidget {
  final String timeline;

  const TripListFuture({super.key, required this.timeline});

  @override
  State<TripListFuture> createState() => _TripListFutureState();
}

class _TripListFutureState extends State<TripListFuture> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<TripDetailsProvider>(context, listen: false)
          .fetchPlannedTrips(widget.timeline),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return const Text("");
        } else {
          return Consumer<TripDetailsProvider>(
            builder: (context, tripDetailsProvider, child) {
              print(tripDetailsProvider.isLoadingFutureTrips);

              if (tripDetailsProvider.isLoadingFutureTrips) {
                return const LoadingWidget();
              }
              return SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tripDetailsProvider.plannedTrips!.length,
                  itemBuilder: (context, index) {
                    if (index < tripDetailsProvider.plannedTrips!.length) {
                      TripInfo? trip = tripDetailsProvider.plannedTrips![index];
                      return TripCard(trip: trip);
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
