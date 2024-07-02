import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SvgPicture.asset(
                      "assets/icons/forgot.svg",
                      width: 200, // Reduced icon size
                      height: 200,
                    ),
          const Text(
            "Ever had that sinking feeling of forgetting something important just as you're about to leave?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            "We've been there too!",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
