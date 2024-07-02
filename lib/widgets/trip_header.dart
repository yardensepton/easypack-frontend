import 'package:flutter/material.dart';

class TripHeader extends StatelessWidget {
  final String imageUrl;
  final String tripTitle;
  final String tripDates;
  final bool isMobile;

  const TripHeader({
    super.key,
    required this.imageUrl,
    required this.tripTitle,
    required this.tripDates,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: isMobile
              ? screenSize.height * 0.3
              : screenSize.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.3),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  tripTitle,
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tripDates,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
