// import 'package:flutter/material.dart';


// class TripList extends StatelessWidget {
//   final List<Trip> trips;

//   const TripList({Key? key, required this.trips}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 160,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: trips.length,
//         itemBuilder: (context, index) {
//           return TripCard(trip: trips[index]);
//         },
//       ),
//     );
//   }
// }
// import 'package:easypack/models/trip_info.dart';
// import 'package:easypack/widgets/trip_card.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:easypack/providers/trip_details_provider.dart';

// class TripList extends StatelessWidget {
//   const TripList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TripDetailsProvider>(
//       builder: (context, tripDetailsProvider, child) {
//         return SizedBox(
//           height: 160,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tripDetailsProvider.plannedTrips?.length ?? 0,
//             itemBuilder: (context, index) {
//               TripInfo? trip = tripDetailsProvider.plannedTrips?[index];
//               if (trip != null) {
//                 return TripCard(trip: trip);
//               } else {
//                 return const SizedBox.shrink();
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';

class TripList extends StatelessWidget {
  final String operand;
  const TripList({super.key,required this.operand});

  @override
  Widget build(BuildContext context) {
    final tripDetailsProvider = Provider.of<TripDetailsProvider>(context, listen: false);

    return FutureBuilder(
      future: tripDetailsProvider.fetchPlannedTrips(operand),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return const Text("");
        } else {
          return Consumer<TripDetailsProvider>(
            builder: (context, tripDetailsProvider, child) {
              return SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tripDetailsProvider.plannedTrips?.length ?? 0,
                  itemBuilder: (context, index) {
                    TripInfo? trip = tripDetailsProvider.plannedTrips?[index];
                    if (trip != null) {
                      return TripCard(trip: trip);
                    } else {
                      return const SizedBox.shrink();
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
