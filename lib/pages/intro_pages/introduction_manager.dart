// import 'package:easypack/pages/intro_pages/intro_page_1.dart';
// import 'package:easypack/pages/intro_pages/intro_page_2.dart';
// import 'package:easypack/pages/intro_pages/intro_page_3.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class IntroductionManager extends StatefulWidget {
//   const IntroductionManager({super.key});

//   @override
//   State<IntroductionManager> createState() => _IntroductionManagerState();
// }

// class _IntroductionManagerState extends State<IntroductionManager> {
//   final PageController _controller = PageController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         PageView(
//           children: const [
//             IntroPage1(),
//             IntroPage2(),
//             IntroPage3(),
//           ],
//         ),
//         Container(
//             alignment: const Alignment(0, 0.75),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   child: const Text('skip'),
//                 ),
//                 SmoothPageIndicator(controller: _controller, count: 3),
//                 GestureDetector(
//                   child: const Text('next'),
//                   onTap:
//                       _controller.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeIn),
//                 ),
//               ],
//             ))
//       ]),

//       // appBar: AppBar(
//       //   title: const Text("Introduction"),
//       // ),
//       // body: Center(
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.center,
//       //     children: <Widget>[
//       //       const Text('Welcome to EasyPack!'),
//       //       ElevatedButton(
//       //         onPressed: () {
//       //           final firstLaunchProvider = Provider.of<FirstLaunchProvider>(context, listen: false);
//       //           firstLaunchProvider.setLaunched();
//       //           Navigator.pushReplacementNamed(context, '/');
//       //         },
//       //         child: const Text('Get Started'),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
import 'package:easypack/pages/intro_pages/intro_page_1.dart';
import 'package:easypack/pages/intro_pages/intro_page_2.dart';
import 'package:easypack/pages/intro_pages/intro_page_3.dart';
import 'package:easypack/providers/first_launch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionManager extends StatefulWidget {
  const IntroductionManager({super.key});

  @override
  State<IntroductionManager> createState() => _IntroductionManagerState();
}

class _IntroductionManagerState extends State<IntroductionManager> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _controller,
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const Text(
                    'back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onTap: () {
                    // Navigate to the main page or set a flag indicating that the introduction has been completed
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ? GestureDetector(
                        child: const Text('done',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/');
                          Provider.of<FirstLaunchProvider>(context,
                                  listen: false)
                              .setLaunched();
                        },
                      )
                    : GestureDetector(
                        child: const Text('next',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
