// import 'package:easypack/models/item_list.dart';
// import 'package:easypack/models/packing_list.dart';
// import 'package:easypack/models/weather.dart';
// import 'package:easypack/widgets/add_item_dialog.dart';
// import 'package:easypack/widgets/packing_list_view.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:easypack/pages/create_packing_list_page.dart';
// import 'package:easypack/providers/packing_list_provider.dart';
// import 'package:easypack/widgets/loading_widget.dart';
// import 'package:easypack/widgets/weather_info.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:easypack/utils/string_extentsion.dart';


// class TripBottomSection extends StatefulWidget {
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
//   State<TripBottomSection> createState() => _TripBottomSectionState();
// }

// class _TripBottomSectionState extends State<TripBottomSection> {
//   @override
//   Widget build(BuildContext context) {
//     print("in build of trip bottom");
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       color: const Color(0xFdfbfbfb),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           WeatherInfo(weatherData: widget.weatherData),
//           FutureBuilder<PackingList?>(
//             future: Provider.of<PackingListProvider>(context)
//                 .getPackingList(widget.tripId),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: LoadingWidget());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData) {
//                 return ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CreatePackingListPage(
//                           tripId: widget.tripId,
//                           tripTitle: widget.tripTitle,
//                         ),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.add),
//                   label: const Text('Create Packing List'),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.green,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: widget.isMobile ? 20 : 25,
//                       vertical: widget.isMobile ? 10 : 12,
//                     ),
//                     textStyle: TextStyle(fontSize: widget.isMobile ? 16 : 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 );
//               } else {
//                 String? description = Provider.of<PackingListProvider>(context)
//                     .currentPackingList!
//                     .description;
//                 List<ItemList> items = Provider.of<PackingListProvider>(context)
//                     .currentPackingList!
//                     .items;

//                 return Column(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 10),
//                     Container(
//                       padding: const EdgeInsets.all(16.0),
//                       margin: const EdgeInsets.only(bottom: 16.0, top: 16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8.0),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         description!,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.indigo[900],
//                           fontStyle: FontStyle.normal,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     PackingListView(items: items,tripId: widget.tripId),
//                   ],
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:easypack/models/item_list.dart';
import 'package:easypack/models/packing_list.dart';
import 'package:easypack/models/weather.dart';
import 'package:easypack/widgets/add_item_dialog.dart';
import 'package:easypack/widgets/packing_list_view.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:easypack/pages/create_packing_list_page.dart';
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripBottomSection extends StatefulWidget {
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

  @override
  State<TripBottomSection> createState() => _TripBottomSectionState();
}

class _TripBottomSectionState extends State<TripBottomSection> {
  late Future<PackingList?> _fetchPackingListFuture;

  @override
  void initState() {
    super.initState();
    _fetchPackingListFuture = Provider.of<PackingListProvider>(context, listen: false)
        .getPackingList(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFdfbfbfb),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeatherInfo(weatherData: widget.weatherData),
          FutureBuilder<PackingList?>(
            future: _fetchPackingListFuture,
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
                          tripId: widget.tripId,
                          tripTitle: widget.tripTitle,
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
                      horizontal: widget.isMobile ? 20 : 25,
                      vertical: widget.isMobile ? 10 : 12,
                    ),
                    textStyle: TextStyle(fontSize: widget.isMobile ? 16 : 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              } else {
                return Consumer<PackingListProvider>(
                  builder: (context, packingListProvider, child) {
                    String? description = packingListProvider.currentPackingList?.description;
                    List<ItemList> items = packingListProvider.currentPackingList?.items ?? [];

                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        if (description != null) 
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.indigo[900],
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        PackingListView(items: items, tripId: widget.tripId),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
