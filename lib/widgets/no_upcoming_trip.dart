import 'package:flutter/material.dart';

class NoUpcomingTrip extends StatelessWidget {
  const NoUpcomingTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You don\'t have an upcoming trip...',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/addTrip'); // Navigate to add trip screen
            },
            icon: const Icon(Icons.add),
            label: const Text('Add a Trip'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
