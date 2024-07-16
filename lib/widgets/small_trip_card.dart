
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/pages/clicked_trip_page.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmallTripCard extends StatelessWidget {
  final TripInfo trip;
  final String boxKey;

  const SmallTripCard({super.key, required this.trip, required this.boxKey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openClickTripPage(context, trip.tripId),
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                trip.cityUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.destination,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${FormatDate.getformatDate(trip.departureDate)} - ${FormatDate.getformatDate(trip.returnDate)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _openClickTripPage(BuildContext context, String tripId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClickedTripPage(tripId: tripId),
      ),
    );
  }
}
