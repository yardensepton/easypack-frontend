import 'package:easypack/providers/click_trip_provider.dart';
import 'package:easypack/widgets/trip_bottom_sheet.dart';
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

    return FutureBuilder(
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
              return Scaffold(
                backgroundColor: const Color(0xFdfbfbfb),
                body: CustomScrollView(slivers: [
                  SliverAppBar(
                    foregroundColor: Colors.white,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsetsDirectional.only(
                          start: 16.0, bottom: 16.0),
                      centerTitle: false,
                      title: Text(
                        "Trip to ${clickTripProvider.destinationName.text}\n${clickTripProvider.startDateController.text} - ${clickTripProvider.endDateController.text}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      background: TripHeader(
                        imageUrl: clickTripProvider.clickDestinationUrl ??
                            'assets/background/gradient.jpg',
                        tripTitle:
                            'Trip to ${clickTripProvider.destinationName.text}',
                        tripDates:
                            '${clickTripProvider.startDateController.text} - ${clickTripProvider.endDateController.text}',
                        isMobile: isMobile,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          _showBottomSheet(context, widget.tripId);
                        },
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: TripBottomSection(
                      tripId: clickTripProvider.clickedTrip!.id!,
                      tripTitle: clickTripProvider.destinationName.text,
                      weatherData:
                          clickTripProvider.clickedTrip?.weatherData ??
                              [],
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

void _showBottomSheet(BuildContext context, String tripId) {
  showModalBottomSheet(
    context: context,
    builder: (context) => TripBottomSheet(tripId: tripId),
  );
}