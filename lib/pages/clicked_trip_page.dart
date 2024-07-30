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
  late Future<void> _fetchTripFuture;

  @override
  void initState() {
    super.initState();
    _fetchTripFuture = Provider.of<ClickTripProvider>(context, listen: false)
        .fetchTripByID(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isMobile = screenSize.width < 600;

    return FutureBuilder<void>(
      future: _fetchTripFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor:  Color(0xFdfbfbfb),
            body: Center(child: LoadingWidget()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            backgroundColor:  Color(0xFdfbfbfb),
            body: Center(child: Text('Error loading trip details')),
          );
        } else {
          return Scaffold(
            backgroundColor: const Color(0xFdfbfbfb),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  foregroundColor: const Color(0xFdfbfbfb),
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsetsDirectional.only(
                        start: 16.0, bottom: 16.0),
                    centerTitle: false,
                    title: Consumer<ClickTripProvider>(
                      builder: (context, clickTripProvider, child) {
                        return Text(
                          "Trip to ${clickTripProvider.destinationName.text}\n${clickTripProvider.startDateController.text} - ${clickTripProvider.endDateController.text}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        );
                      },
                    ),
                    background: Consumer<ClickTripProvider>(
                      builder: (context, clickTripProvider, child) {
                        return TripHeader(
                          imageUrl: clickTripProvider.clickDestinationUrl ??
                              'assets/background/gradient.jpg',
                          tripTitle:
                              'Trip to ${clickTripProvider.destinationName.text}',
                          tripDates:
                              '${clickTripProvider.startDateController.text} - ${clickTripProvider.endDateController.text}',
                          isMobile: isMobile,
                        );
                      },
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
                  child: Consumer<ClickTripProvider>(
                    builder: (context, clickTripProvider, child) {
                      if (clickTripProvider.isLoading) {
                        return const Center(child: LoadingWidget());
                      } else if (clickTripProvider.clickedTrip == null) {
                        return const Center(child: Text('No trip data available'));
                      } else {
                         print(clickTripProvider.clickedTrip.toString());
                        return TripBottomSection(
                          tripId: clickTripProvider.clickedTrip!.id!,
                          tripTitle: clickTripProvider.destinationName.text,
                          weatherData:
                              clickTripProvider.clickedTrip?.weatherData ?? [],
                          isMobile: isMobile,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void _showBottomSheet(BuildContext context, String tripId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TripBottomSheet(tripId: tripId),
    );
  }
}
