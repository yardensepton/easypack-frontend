import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoadingPackingList extends StatelessWidget {
  const LoadingPackingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 300),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Working on it!',
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 400),
              ),
            ],
          ),
          Lottie.asset(
            "assets/lottie/flight_loading.json",
            width: 100,
          ),
          const SizedBox(height: 300),
        ],
      ),
    );
  }
}
