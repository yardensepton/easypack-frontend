import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  final String title;

  const SeeAllButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle see all button press
          },
          child: const Text('See all'),
        ),
      ],
    );
  }
}