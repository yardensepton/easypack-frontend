// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class IntroPage3 extends StatelessWidget {
//   const IntroPage3({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white10,
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [

//           SvgPicture.asset(
//                       "assets/icons/list.svg",
//                       width: 200, // Reduced icon size
//                       height: 200,
//                     ),
//                     const SizedBox(height: 10),
//           const Text(
//             "EasyPack is here for everyone!",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "We personalize your packing list based on your trip's weather and the temperatures you're used to, ensuring you're prepared for every journey.",
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.black,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "With EasyPack, you can easily customize your packing list to suit your unique preferences and needs.",
//             style: TextStyle(
//               fontSize: 17,
//               color: Colors.black,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:easypack/providers/first_launch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/list.svg",
            width: 200, // Reduced icon size
            height: 200,
          ),
          const SizedBox(height: 10),
          const Text(
            "EasyPack is here for everyone!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "We personalize your packing list based on your trip's weather and the temperatures you're used to, ensuring you're prepared for every journey.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            "With EasyPack, you can easily customize your packing list to suit your unique preferences and needs.",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
              Provider.of<FirstLaunchProvider>(context, listen: false)
                  .setLaunched();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text(
              "Let's start!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
