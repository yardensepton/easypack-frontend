import 'package:easypack/models/packing_list.dart';
import 'package:easypack/models/weather.dart';
import 'package:easypack/widgets/packing_list_view.dart';
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
    _fetchPackingListFuture =
        Provider.of<PackingListProvider>(context, listen: false)
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
              } else {
                return Consumer<PackingListProvider>(
                  builder: (context, packingListProvider, child) {
                    return Column(
                      children: [
                        PackingListView(
                          tripId: widget.tripId,
                          tripTitle: widget.tripTitle,
                          isMobile: widget.isMobile,
                        ),
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
