import 'package:easypack/models/trip_info.dart';
import 'package:easypack/pages/all_trips_list.dart';
import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  final String title;
  final List<TripInfo> trips;
  const SeeAllButton({super.key, required this.title, required this.trips});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
           _openAllTripsPage(context,trips,title);
          },
          child: Text('See all', style: TextStyle(color: Colors.indigo[900])),
        ),
      ],
    );
  }
}

void _openAllTripsPage(BuildContext context, List<TripInfo> trips, String title) {
  Navigator.of(context).push(_createRoute(trips,title));
}

Route _createRoute(List<TripInfo> trips,String title) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        AllTripsList(trips: trips,title: title,),
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
