import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPackingList extends StatelessWidget {
  const LoadingPackingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        
        children: [
          const SizedBox(height: 100),
                    const Text(
            'Building your personalized packing list!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Lottie.asset(
            "assets/lottie/flight_loading.json",width: 100,
          ),
          const SizedBox(height: 100),

        ],
      ),
    );
  }
}
