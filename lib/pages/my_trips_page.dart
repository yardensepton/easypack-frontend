import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
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
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('My Trips'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 20), // Add some space between the greeting and the planned trips section
              const SeeAllButton(title: 'Planned trips'),
              const SizedBox(height: 10),
              const TripListFuture(timeline: Timeline.future),
              const SizedBox(height: 30),
              const SeeAllButton(title: 'Past trips'),
              const SizedBox(height: 10),
              const TripListPast(timeline: Timeline.past),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: const Icon(Icons.logout_rounded,color: Colors.white,),
        onPressed: () => logOutButton(context),
      ),
    );
  }
}

