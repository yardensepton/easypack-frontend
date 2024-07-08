import 'package:flutter/material.dart';

class CreatePackingListHeader extends StatelessWidget {
  final String tripTitle;
  final bool isMobile;

  const CreatePackingListHeader({
    super.key,
    required this.tripTitle,
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/packing_list.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Let's create\nthe perfect packing list\nfor your trip\nto $tripTitle!",
                  softWrap: true,
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                // Text(
                //   tripDates,
                //   style: TextStyle(
                //     fontSize: isMobile ? 12 : 10,
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
