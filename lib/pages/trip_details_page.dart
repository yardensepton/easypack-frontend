import 'package:easypack/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/no_upcoming_trip.dart';

class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({super.key});

  @override
  _TripDetailsPageState createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
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
                  Stack(
                    children: [
                      Container(
                        height: isMobile
                            ? screenSize.height * 0.3
                            : screenSize.height * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              tripDetailsProvider.cachedDestinationUrl ??
                                  'assets/background/gradient.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.3), // Adjust opacity as needed
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment
                                .end, // Align text at the baseline
                            children: [
                              Text(
                                'Trip to ${tripDetailsProvider.destinationName.text}',
                                style: TextStyle(
                                  fontSize: isMobile ? 20 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${tripDetailsProvider.startDateController.text} - ${tripDetailsProvider.endDateController.text}',
                                style: TextStyle(
                                    fontSize: isMobile ? 12 : 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Bottom section with text and buttons
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WeatherInfo(
                            weatherData:
                                tripDetailsProvider.cachedTrip?.weatherData ??
                                    [],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add functionality here
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Create Equipment List'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 25,
                                vertical: isMobile ? 10 : 12,
                              ),
                              textStyle:
                                  TextStyle(fontSize: isMobile ? 16 : 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              tripDetailsProvider.fetchUpcomingTrip(
                                  forceRefresh: true);
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Refresh'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 25,
                                vertical: isMobile ? 10 : 12,
                              ),
                              textStyle:
                                  TextStyle(fontSize: isMobile ? 16 : 14),
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
              );
            }
          }
        },
      ),
    );
  }
}
