import 'dart:ui';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/list_weather_days.dart';
import 'package:easypack/widgets/loading_widget.dart';
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
    Size screenSize = MediaQuery.of(context).size;
    bool isMobile = screenSize.width < 600;

    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<TripDetailsProvider>(context, listen: false).fetchUpcomingTrip(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingWidget());
          } else if (snapshot.hasError) {
            print("Error fetching upcoming trip: ${snapshot.error}");
            return const NoUpcomingTrip();
          } else {
            final tripDetailsProvider = Provider.of<TripDetailsProvider>(context);

            if (!tripDetailsProvider.hasUpcomingTrip) {
              return const NoUpcomingTrip();
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: isMobile ? screenSize.height * 0.3 : screenSize.height * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                tripDetailsProvider.cachedDestinationUrl ?? 'assets/background/gradient.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 16,
                          right: 16,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.black.withOpacity(0.3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trip to ${tripDetailsProvider.destinationName.text}',
                                    style: TextStyle(
                                      fontSize: isMobile ? 20 : 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'From: ${tripDetailsProvider.startDateController.text} - To: ${tripDetailsProvider.endDateController.text}',
                                    style: TextStyle(
                                      fontSize: isMobile ? 12 : 10,
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
                    Container(
                      // height: screenSize.height*0.7,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ListWeatherDays(),
                          const SizedBox(height: 10),
                          Text(
                            'Enjoy your trip to ${tripDetailsProvider.destinationName.text}!',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 14,
                              color: const Color.fromARGB(255, 39, 37, 37),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
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
                              textStyle: TextStyle(fontSize: isMobile ? 16 : 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              tripDetailsProvider.fetchUpcomingTrip(forceRefresh: true);
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
                              textStyle: TextStyle(fontSize: isMobile ? 16 : 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
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