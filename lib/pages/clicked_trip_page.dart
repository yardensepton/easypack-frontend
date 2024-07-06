import 'package:easypack/providers/click_trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/trip_header.dart';
import 'package:easypack/widgets/trip_bottom_section.dart';

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
                  TripHeader(
                    imageUrl: clickTripProvider.clickDestinationUrl ??
                        'assets/background/gradient.jpg',
                    tripTitle: 'Trip to ${clickTripProvider.destinationName.text}',
                    tripDates: '${clickTripProvider.startDateController.text} - ${clickTripProvider.endDateController.text}',
                    isMobile: isMobile,
                  ),
                  TripBottomSection(
                    tripTitle:clickTripProvider.destinationName.text,
                    weatherData: clickTripProvider.clickedTrip?.weatherData ?? [],
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
