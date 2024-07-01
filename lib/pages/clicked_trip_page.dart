import 'package:easypack/providers/click_trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/weather_info.dart';

class ClickedTripPage extends StatefulWidget {
  final String tripId;

  const ClickedTripPage({super.key, required this.tripId});

  @override
  State<ClickedTripPage> createState() => _ClickedTripPageState();
}

class _ClickedTripPageState extends State<ClickedTripPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isMobile = screenSize.width < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white, 
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Provider.of<ClickTripProvider>(context, listen: false)
            .fetchTripByID(widget.tripId),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingWidget());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading trip details'));
          } else {
            final clickTripProvider = Provider.of<ClickTripProvider>(context);
            if (clickTripProvider.isLoading) {
              return const LoadingWidget();
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
                              clickTripProvider.clickDestinationUrl ??
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
                                'Trip to ${clickTripProvider.destinationName.text}',
                                style: TextStyle(
                                  fontSize: isMobile ? 20 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${clickTripProvider.startDateController.text} - ${clickTripProvider.endDateController.text}',
                                style: TextStyle(
                                  fontSize: isMobile ? 12 : 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
                          const WeatherInfo(),
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
