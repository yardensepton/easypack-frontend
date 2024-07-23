import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/pages/no_trips.dart';
import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/custom_drawer.dart';
import 'package:easypack/widgets/see_all_button.dart';
import 'package:easypack/widgets/trip_list_future.dart';
import 'package:easypack/widgets/trip_list_past.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({super.key});

  void logOutButton(BuildContext context) {
    Provider.of<TripDetailsProvider>(context, listen: false).reset();
    Provider.of<AuthUserProvider>(context, listen: false).logOutUser(context);
    Provider.of<CreateUserProvider>(context, listen: false)
        .moveToLoginScreen(context);
    Provider.of<AutoCompleteProvider>(context, listen: false)
        .clearResultsBeforeNewSearch();
    Provider.of<ChooseDateRangeProvider>(context, listen: false)
        .clearControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFdfbfbfb),
      appBar: AppBar(
        backgroundColor: const Color(0xFdfbfbfb),
        title: const Text('My Trips'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<TripDetailsProvider>(
          builder: (context, tripDetailsProvider, child) {
            if (tripDetailsProvider.hasNoTrips) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<AuthUserProvider>(
                    builder: (context, authUserProvider, child) {
                      return Text(
                        'Hi, ${authUserProvider.userName.text} 👋🏻',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const NoTrips(),
                ],
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<AuthUserProvider>(
                      builder: (context, authUserProvider, child) {
                        return Text(
                          'Hi, ${authUserProvider.userName.text} 👋🏻',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const SeeAllButton(title: 'Planned trips'),
                    const SizedBox(height: 10),
                    const TripListFuture(timeline: Timeline.future),
                    const SizedBox(height: 30),
                    const SeeAllButton(title: 'Past trips'),
                    const SizedBox(height: 10),
                    const TripListPast(timeline: Timeline.past),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
