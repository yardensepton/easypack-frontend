import 'dart:developer';

import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/widgets/see_all_button.dart';
import 'package:easypack/widgets/trip_list_future.dart';
import 'package:easypack/widgets/trip_list_past.dart';
import 'package:flutter/material.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeeAllButton(title: 'Planned trips'),
              SizedBox(height: 10),
              TripListFuture(timeline: Timeline.future),
              SizedBox(height: 30),
              SeeAllButton(title: 'Past trips'),
              SizedBox(height: 10),
              TripListPast(timeline: Timeline.past),
            ],
          ),
        ),
      ),
    );
  }
}