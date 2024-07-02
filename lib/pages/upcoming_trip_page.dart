import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/no_upcoming_trip.dart';
import 'package:easypack/widgets/trip_header.dart';
import 'package:easypack/widgets/trip_bottom_section.dart';

class UpcomingTripPage extends StatefulWidget {
  const UpcomingTripPage({super.key});

  @override
  _UpcomingTripPageState createState() => _UpcomingTripPageState();
}

class _UpcomingTripPageState extends State<UpcomingTripPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isMobile = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Provider.of<TripDetailsProvider>(context, listen: false)
            .fetchUpcomingTrip(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingWidget());
          } else if (snapshot.hasError) {
            return const NoUpcomingTrip();
          } else {
            final tripDetailsProvider =
                Provider.of<TripDetailsProvider>(context);
            if (tripDetailsProvider.isLoading) {
              return const LoadingWidget();
            }

            if (!tripDetailsProvider.hasUpcomingTrip) {
              return const NoUpcomingTrip();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TripHeader(
                    imageUrl: tripDetailsProvider.cachedDestinationUrl ??
                        'assets/background/gradient.jpg',
                    tripTitle: 'Trip to ${tripDetailsProvider.destinationName.text}',
                    tripDates: '${tripDetailsProvider.startDateController.text} - ${tripDetailsProvider.endDateController.text}',
                    isMobile: isMobile,
                  ),
                  TripBottomSection(
                    weatherData: tripDetailsProvider.cachedTrip?.weatherData ?? [],
                    isMobile: isMobile,
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
