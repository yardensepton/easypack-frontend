import 'package:easypack/models/weather.dart';
import 'package:easypack/pages/create_packing_list_page.dart';
import 'package:flutter/material.dart';
import 'package:easypack/widgets/weather_info.dart';

class TripBottomSection extends StatelessWidget {
  final String tripTitle; 
  final List<Weather> weatherData;
  final bool isMobile;

  const TripBottomSection({
    super.key,
    required this.tripTitle,
    required this.weatherData,
    required this.isMobile,
  });

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
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  CreatePackingListPage(tripTitle:tripTitle)),
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
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}