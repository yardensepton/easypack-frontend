// // import 'package:easypack/models/weather.dart';
// // import 'package:easypack/pages/create_packing_list_page.dart';
// // import 'package:flutter/material.dart';
// // import 'package:easypack/widgets/weather_info.dart';

// // class TripBottomSection extends StatelessWidget {
// //   final String tripTitle; 
// //   final String tripId;
// //   final List<Weather> weatherData;
// //   final bool isMobile;

// //   const TripBottomSection({
// //     super.key,
// //     required this.tripTitle,
// //     required this.tripId,
// //     required this.weatherData,
// //     required this.isMobile,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       child: Container(
// //         padding: const EdgeInsets.all(16.0),
// //         color: Colors.white10,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             WeatherInfo(weatherData: weatherData),
// //             const SizedBox(height: 10),
// //             ElevatedButton.icon(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) =>  CreatePackingListPage(tripId: tripId,tripTitle:tripTitle)),
// //                 );
// //               },
// //               icon: const Icon(Icons.add),
// //               label: const Text('Create Packing List'),
// //               style: ElevatedButton.styleFrom(
// //                 foregroundColor: Colors.white,
// //                 backgroundColor: Colors.green,
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: isMobile ? 20 : 25,
// //                   vertical: isMobile ? 10 : 12,
// //                 ),
// //                 textStyle: TextStyle(fontSize: isMobile ? 16 : 14),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // import 'package:easypack/models/item_list.dart';
// // import 'package:easypack/models/packing_list.dart';
// // import 'package:easypack/models/weather.dart';
// // import 'package:easypack/pages/create_packing_list_page.dart';
// // import 'package:easypack/providers/packing_list_provider.dart';
// // import 'package:easypack/widgets/loading_widget.dart';
// // import 'package:easypack/widgets/weather_info.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // class TripBottomSection extends StatelessWidget {
// //   final String tripTitle; 
// //   final String tripId;
// //   final List<Weather> weatherData;
// //   final bool isMobile;

// //   const TripBottomSection({
// //     super.key,
// //     required this.tripTitle,
// //     required this.tripId,
// //     required this.weatherData,
// //     required this.isMobile,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       child: Container(
// //         padding: const EdgeInsets.all(16.0),
// //         color: Colors.white10,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             WeatherInfo(weatherData: weatherData),
// //             const SizedBox(height: 10),
// //             FutureBuilder<PackingList?>(
// //               future: Provider.of<PackingListProvider>(context)
// //                   .getPackingList(tripId),
// //               builder: (context, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return const Center(child: LoadingWidget());
// //                 } else if (snapshot.hasError) {
// //                   return Center(child: Text('Error: ${snapshot.error}'));
// //                 } else if (!snapshot.hasData) {
// //                   return ElevatedButton.icon(
// //                     onPressed: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => CreatePackingListPage(
// //                             tripId: tripId,
// //                             tripTitle: tripTitle,
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                     icon: const Icon(Icons.add),
// //                     label: const Text('Create Packing List'),
// //                     style: ElevatedButton.styleFrom(
// //                       foregroundColor: Colors.white,
// //                       backgroundColor: Colors.green,
// //                       padding: EdgeInsets.symmetric(
// //                         horizontal: isMobile ? 20 : 25,
// //                         vertical: isMobile ? 10 : 12,
// //                       ),
// //                       textStyle: TextStyle(fontSize: isMobile ? 16 : 14),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                     ),
// //                   );
// //                 } else {
// //                   // Packing list data available
// //                   List<ItemList> packingList = Provider.of<PackingListProvider>(context).currentPackingList!.items;
// //                   return ListView.builder(
// //                     shrinkWrap: true,
// //                     itemCount: packingList.length,
// //                     itemBuilder: (context, index) {
// //                       ItemList item = packingList[index];
// //                       return ListTile(
// //                         title: Text(item.itemName),
// //                         subtitle: Text(item.category),
// //                         trailing: Text('${item.amountPerTrip}'),
// //                       );
// //                     },
// //                   );
// //                 }
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:easypack/models/item_list.dart';
// import 'package:easypack/models/packing_list.dart';
// import 'package:easypack/models/weather.dart';
// import 'package:easypack/pages/create_packing_list_page.dart';
// import 'package:easypack/providers/packing_list_provider.dart';
// import 'package:easypack/utils/string_extentsion.dart';
// import 'package:easypack/widgets/loading_widget.dart';
// import 'package:easypack/widgets/weather_info.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TripBottomSection extends StatelessWidget {
//   final String tripTitle; 
//   final String tripId;
//   final List<Weather> weatherData;
//   final bool isMobile;

//   const TripBottomSection({
//     super.key,
//     required this.tripTitle,
//     required this.tripId,
//     required this.weatherData,
//     required this.isMobile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         color: Colors.white10,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             WeatherInfo(weatherData: weatherData),
//             FutureBuilder<PackingList?>(
//               future: Provider.of<PackingListProvider>(context)
//                   .getPackingList(tripId),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: LoadingWidget());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData) {
//                   return ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CreatePackingListPage(
//                             tripId: tripId,
//                             tripTitle: tripTitle,
//                           ),
//                         ),
//                       );
//                     },
//                     icon: const Icon(Icons.add),
//                     label: const Text('Create Packing List'),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: Colors.green,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: isMobile ? 20 : 25,
//                         vertical: isMobile ? 10 : 12,
//                       ),
//                       textStyle: TextStyle(fontSize: isMobile ? 16 : 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   );
//                 } else {
//                   // Packing list data available
//                   List<ItemList> packingList = Provider.of<PackingListProvider>(context).currentPackingList!.items;
//                   return Expanded(
//                     child: ListView.separated(
//                       shrinkWrap: true,
//                       itemCount: packingList.length,
//                       separatorBuilder: (context, index) => const Divider(),
//                       itemBuilder: (context, index) {
//                         ItemList item = packingList[index];
//                         return ListTile(
//                           title: Text(item.itemName.capitalize()),
//                           subtitle: Text(item.category.capitalize()),
//                           trailing: Text('${item.amountPerTrip}'),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:easypack/models/item_list.dart';
import 'package:easypack/models/packing_list.dart';
import 'package:easypack/models/weather.dart';
import 'package:easypack/pages/create_packing_list_page.dart';
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/utils/string_extentsion.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripBottomSection extends StatelessWidget {
  final String tripTitle;
  final String tripId;
  final List<Weather> weatherData;
  final bool isMobile;

  const TripBottomSection({
    super.key,
    required this.tripTitle,
    required this.tripId,
    required this.weatherData,
    required this.isMobile,
  });

  // Function to group items by category
  Map<String, List<ItemList>> _groupItemsByCategory(List<ItemList> items) {
    Map<String, List<ItemList>> groupedItems = {};
    for (var item in items) {
      if (groupedItems.containsKey(item.category)) {
        groupedItems[item.category]!.add(item);
      } else {
        groupedItems[item.category] = [item];
      }
    }
    return groupedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeatherInfo(weatherData: weatherData),
            FutureBuilder<PackingList?>(
              future: Provider.of<PackingListProvider>(context)
                  .getPackingList(tripId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingWidget());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return ElevatedButton.icon(
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
                    icon: const Icon(Icons.add),
                    label: const Text('Create Packing List'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 25,
                        vertical: isMobile ? 10 : 12,
                      ),
                      textStyle: TextStyle(fontSize: isMobile ? 16 : 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                } else {
                  // Packing list data available
                  List<ItemList> packingList = Provider.of<PackingListProvider>(context).currentPackingList!.items;
                  Map<String, List<ItemList>> groupedItems = _groupItemsByCategory(packingList);

                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupedItems.length,
                      itemBuilder: (context, index) {
                        String category = groupedItems.keys.elementAt(index);
                        List<ItemList> items = groupedItems[category]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                category.capitalize(),
                                style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                
                              ),
                            ),
                            ...items.map((item) => ListTile(
                              title: Text(item.itemName.capitalize()),
                              trailing: Text('${item.amountPerTrip}'),
                            )),
                            if (index < groupedItems.length - 1) const Divider(),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
