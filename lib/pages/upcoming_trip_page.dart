import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/loading_widget.dart';
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

    return FutureBuilder(
        future: Provider.of<TripDetailsProvider>(context, listen: false)
            .fetchUpcomingTrip(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingWidget());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading trip details'));
          } else {
            final tripDetailsProvider =
                Provider.of<TripDetailsProvider>(context);
            if (tripDetailsProvider.isLoading) {
              return const LoadingWidget();
            } else {
              return Scaffold(
                body: CustomScrollView(slivers: [
                  SliverAppBar(
                    foregroundColor: Colors.white,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsetsDirectional.only(
                          start: 16.0, bottom: 16.0),
                      centerTitle: false,
                      title: Text(
                        "Trip to ${tripDetailsProvider.destinationName.text}\n${tripDetailsProvider.startDateController.text} - ${tripDetailsProvider.endDateController.text}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      background: TripHeader(
                        imageUrl: tripDetailsProvider.cachedDestinationUrl ??
                            'assets/background/gradient.jpg',
                        tripTitle:
                            'Trip to ${tripDetailsProvider.destinationName.text}',
                        tripDates:
                            '${tripDetailsProvider.startDateController.text} - ${tripDetailsProvider.endDateController.text}',
                        isMobile: isMobile,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: TripBottomSection(
                      tripId: tripDetailsProvider.cachedTrip!.id!,
                      tripTitle: tripDetailsProvider.destinationName.text,
                      weatherData:
                          tripDetailsProvider.cachedTrip?.weatherData ?? [],
                      isMobile: isMobile,
                    ),
                  )
                ]),
              );
            }
          }
        });
  }
}


