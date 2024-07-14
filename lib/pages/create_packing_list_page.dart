// // import 'package:easypack/widgets/packing_list_stepper.dart';
// // import 'package:flutter/material.dart';

// // class CreatePackingListPage extends StatefulWidget {
// //   final String tripTitle;
// //   final DateTime departureDate = DateTime(2023, 5, 1);
// //   final DateTime returnDate = DateTime(2023, 5, 7);

// //   CreatePackingListPage({super.key, required this.tripTitle});

// //   @override
// //   _CreatePackingListPageState createState() => _CreatePackingListPageState();
// // }

// // class _CreatePackingListPageState extends State<CreatePackingListPage> {

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         extendBodyBehindAppBar: true,
// //         backgroundColor: Colors.white,
// //         appBar: AppBar(
// //           elevation: 0,
// //           backgroundColor: Colors.transparent,
// //           title: const Text('New Packing List'),
// //           centerTitle: true,
// //         ),
// //         body: const PackingListStepper());
// //   }
// // }


//   // final List<Map<String, dynamic>> categories = [
//   //   {'name': 'Business Trip', 'icon': Icons.business_center, 'selected': false},
//   //   {'name': 'Ski Trip', 'icon': Icons.ac_unit, 'selected': false},
//   //   {'name': 'Baby Trip', 'icon': Icons.child_friendly, 'selected': false},
//   //   {'name': 'Car Trip', 'icon': Icons.directions_car, 'selected': false},
//   // ];


//    // CreatePackingListHeader(
//             //   tripTitle:
//             //       widget.tripTitle,
//             //   isMobile: isMobile,
//             // ),
//             // Expanded(
//             //   child: GridView.builder(
//             //     itemCount: categories.length,
//             //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             //       crossAxisCount: 2,
//             //       crossAxisSpacing: 16.0,
//             //       mainAxisSpacing: 16.0,
//             //     ),
//             //     itemBuilder: (context, index) {
//             //       final category = categories[index];
//             //       return GestureDetector(
//             //         onTap: () {
//             //           setState(() {
//             //             category['selected'] = !category['selected'];
//             //           });
//             //         },
//             //         child: Card(
//             //           elevation: 4,
//             //           shape: RoundedRectangleBorder(
//             //             borderRadius: BorderRadius.circular(10),
//             //           ),
//             //           child: Column(
//             //             mainAxisAlignment: MainAxisAlignment.center,
//             //             children: [
//             //               Icon(
//             //                 category['icon'],
//             //                 size: 60,
//             //                 color: category['selected']
//             //                     ? Colors.teal
//             //                     : Colors.grey,
//             //               ),
//             //               const SizedBox(height: 10),
//             //               Text(
//             //                 category['name'],
//             //                 style: TextStyle(
//             //                   fontSize: 16,
//             //                   fontWeight: FontWeight.bold,
//             //                   color: category['selected']
//             //                       ? Colors.teal
//             //                       : Colors.black,
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       );
//             //     },
//             //   ),
//             // ),
//           //   const SizedBox(height: 20),
//           //   ElevatedButton(
//           //     onPressed: () {
//           //       // Handle save action
//           //     },
//           //     style: ElevatedButton.styleFrom(
//           //       foregroundColor: Colors.white,
//           //       backgroundColor: Colors.teal,
//           //       padding:
//           //           const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//           //       textStyle: const TextStyle(fontSize: 18),
//           //       shape: RoundedRectangleBorder(
//           //         borderRadius: BorderRadius.circular(10),
//           //       ),
//           //     ),
//           //     child: const Text('Save'),
//           //   ),
//          import 'package:flutter/material.dart';
// import 'package:easypack/widgets/packing_list_stepper.dart';

// class CreatePackingListPage extends StatefulWidget {
//   final String tripTitle;
//   final DateTime departureDate = DateTime(2023, 5, 1);
//   final DateTime returnDate = DateTime(2023, 5, 7);

//   CreatePackingListPage({super.key, required this.tripTitle});

//   @override
//   _CreatePackingListPageState createState() => _CreatePackingListPageState();
// }

// class _CreatePackingListPageState extends State<CreatePackingListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: const Text('New Packing List'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             minHeight: MediaQuery.of(context).size.height,
//           ),
//           child: const IntrinsicHeight(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//                   child: PackingListStepper(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:easypack/widgets/packing_list_stepper.dart';
import 'package:flutter/material.dart';

class CreatePackingListPage extends StatefulWidget {
  final String tripTitle;

  const CreatePackingListPage({super.key, required this.tripTitle});

  @override
  _CreatePackingListPageState createState() => _CreatePackingListPageState();
}

class _CreatePackingListPageState extends State<CreatePackingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('New Packing List'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: PackingListStepper(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

