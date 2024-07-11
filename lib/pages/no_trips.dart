import 'package:flutter/material.dart';

class NoTrips extends StatelessWidget {
  const NoTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No trips? No problem!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Start planning your next adventure and let us handle your packing list.\nWe'll make sure you have everything you need, so you can travel worry-free.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Spacer(),
            Text(
              'Tap the + button to get started',
              style: TextStyle(
                fontSize: 18,
              ),
            ), // Expands to fill remaining space
          ],
        ),
      ),
    );
  }
}
