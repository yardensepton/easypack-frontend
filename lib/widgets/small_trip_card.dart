import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/pages/clicked_trip_page.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';

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
              child: CachedNetworkImage(
                imageUrl: trip.cityUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/background/gradient.jpg',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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
    Navigator.of(context).push(_createRoute(tripId));
  }
}

Route _createRoute(String tripId) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ClickedTripPage(tripId: tripId),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
