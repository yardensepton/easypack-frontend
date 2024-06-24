import 'dart:ui';

import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/list_weather_days.dart';
import 'package:easypack/widgets/no_upcoming_trip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({super.key});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<TripDetailsProvider>(context, listen: false)
            .fetchUpcomingTrip(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error fetching upcoming trip: ${snapshot.error}");
            return const Center(
              child: Text('Error fetching data. Please try again later.'),
            );
          } else {
            final tripDetailsProvider =
                Provider.of<TripDetailsProvider>(context);

            if (!tripDetailsProvider.hasUpcomingTrip) {
              return const NoUpcomingTrip();
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            tripDetailsProvider.cachedDestinationUrl ??
                                'lib/assets/background/gradient.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'lib/assets/background/gradient.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            right: 16,
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.black.withOpacity(0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Trip to ${tripDetailsProvider.destinationName.text}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'From: ${tripDetailsProvider.startDateController.text} - To: ${tripDetailsProvider.endDateController.text}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ListWeatherDays(),
                          const SizedBox(height: 10),
                          Text(
                            'Enjoy your trip to ${tripDetailsProvider.destinationName.text}!',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 39, 37, 37),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Implement action
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Create Equipment List'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              textStyle: const TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: () {
                              tripDetailsProvider.fetchUpcomingTrip(
                                  forceRefresh: true);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
