import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      padding: const EdgeInsets.all(20.0),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome to EasyPack!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            "Have you ever found yourself staring at your suitcase, unsure of what to pack for your next adventure?",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
           SvgPicture.asset(
                      "assets/icons/suitcase_question.svg",
                      width: 150, // Reduced icon size
                      height: 150,
                    ),
        ],
      ),
    );
  }
}
