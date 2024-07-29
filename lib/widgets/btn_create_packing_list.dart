// import 'package:easypack/pages/create_packing_list_page.dart';
// import 'package:flutter/material.dart';

// class BtnCreatePackingList extends StatelessWidget {
//   final String tripId;
//   final String tripTitle;
//   final bool isMobile;
//   const BtnCreatePackingList(
//       {super.key, required this.tripId, required this.tripTitle,required this.isMobile});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CreatePackingListPage(
//               tripId: tripId,
//               tripTitle: tripTitle,
//             ),
//           ),
//         );
//       },
//       icon: const Icon(Icons.add),
//       label: const Text('Create Packing List'),
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.green,
//         padding: EdgeInsets.symmetric(
//           horizontal: isMobile ? 20 : 25,
//           vertical: isMobile ? 10 : 12,
//         ),
//         textStyle: TextStyle(fontSize: isMobile ? 16 : 14),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }
import 'package:easypack/pages/create_packing_list_page.dart';
import 'package:flutter/material.dart';

class BtnCreatePackingList extends StatelessWidget {
  final String tripId;
  final String tripTitle;
  final bool isMobile;

  const BtnCreatePackingList({
    super.key,
    required this.tripId,
    required this.tripTitle,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePackingListPage(
                tripId: tripId,
                tripTitle: tripTitle,
              ),
            ),
          );
        },
        icon: const Icon(Icons.list, size: 20), // Adjusted size for better visibility
        label: Text(
          'Create Packing List',
          style: TextStyle(fontSize: isMobile ? 18 : 16), // Adjusted font size for better readability
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor:  Colors.indigo[900], // Use onPrimary for the icon color
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 30, // Adjusted padding for better button size
            vertical: isMobile ? 12 : 15, // Adjusted padding for better button size
          ),
          textStyle: TextStyle(
            fontSize: isMobile ? 18 : 16, // Consistent font size
            fontWeight: FontWeight.normal, // Added bold font weight
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Slightly more rounded corners
          ),
          elevation: 5, // Added shadow for a more modern look
        ),
      ),
    );
  }
}
