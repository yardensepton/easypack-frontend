import 'package:easypack/widgets/add_item_dialog.dart';
import 'package:easypack/widgets/packing_list_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/trip_header.dart';
import 'package:easypack/widgets/trip_bottom_section.dart';

class UpcomingTripPage extends StatefulWidget {
  const UpcomingTripPage({super.key});

  @override
 State<UpcomingTripPage> createState() => _UpcomingTripPageState();
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
            } if(
              tripDetailsProvider.cachedTrip == null){
                return const Center(child: Text('No upcoming trip found.'));
              }else {
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
                    actions: [
                        IconButton(
                          onPressed: () {
                            _showBottomSheet(context, tripDetailsProvider.cachedTrip!.id!);
                          },
                          icon: const Icon(Icons.more_horiz),
                        ),
                      ],
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

                // floatingActionButton: hasPackingList
                //     ? FloatingActionButton(
                //         backgroundColor: Colors.indigo[900],
                //         tooltip: 'Add Item',
                //         onPressed: () {
                //           showAddItemDialog(context);
                //         },
                //         child: const Icon(Icons.add,
                //             color: Colors.white, size: 28),
                //       )
                //     : null,

              );
            }
          }
        });
  }
}
void showAddItemDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddItemDialog();
    },
  );
}

  void _showBottomSheet(BuildContext context, String tripId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => PackingListBottomSheet(tripId: tripId),
    );
  }