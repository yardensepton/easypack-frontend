import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/trip.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/services/trip_service.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class TripDetailsProvider extends ChangeNotifier {
  final TripService _tripService = TripService();
  TextEditingController destinationName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  Box<TripInfo> tripsBox = Hive.box(Boxes.tripsBox);
  bool isLoading = false;
  bool isLoadingPastTrips = false;
  bool isLoadingFutureTrips = false;
  Trip? cachedTrip;
  String? cachedDestinationUrl;
  List<TripInfo> plannedTrips = [];
  List<TripInfo> pastTrips = [];
  bool hasUpcomingTrip = false;

  void reset() {
    tripsBox.clear();
    cachedTrip = null;
    isLoading = false;
    cachedDestinationUrl = null;
    hasUpcomingTrip = false;
    notifyListeners();
  }

  Future<void> fetchUpcomingTrip({bool forceRefresh = false}) async {
    try {
      isLoading = true;

      if (plannedTrips.isEmpty) {
        hasUpcomingTrip = false;
        cachedTrip = null;
        destinationName.text = '';
        startDateController.text = '';
        endDateController.text = '';
        isLoading = false;
        return;
      }

      cachedTrip = await _tripService.getTripById(plannedTrips.first.tripId);

      if (cachedTrip != null) {
        hasUpcomingTrip = true;
        _updateControllers(cachedTrip!);
        cachedDestinationUrl = cachedTrip!.destination.cityUrl;
      } else {
        hasUpcomingTrip = false;
        destinationName.text = '';
        startDateController.text = '';
        endDateController.text = '';
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      throw Exception('$e');
    }
  }

  Future<void> deleteTripById(String tripId, String boxKey) async {
    try {
      await _tripService.deleteTripById(tripId);

      if (tripsBox.containsKey(tripId)) {
        tripsBox.delete(tripId);
        if (boxKey == Timeline.future) {
          plannedTrips.removeWhere((trip) => trip.tripId == tripId);
        } else {
          pastTrips.removeWhere((trip) => trip.tripId == tripId);
        }
        print("Trip with id $tripId deleted from Hive box.");
        print("Remaining trips in Hive box: ${tripsBox.values.length}");
        notifyListeners();
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<TripInfo>?> fetchPlannedTrips(String timeline,
      {bool forceRefresh = false}) async {
    if (!forceRefresh & tripsBox.isNotEmpty) {
      return categorizeTrips(timeline);
    }
    try {
      List<TripInfo>? trips = await _tripService.getPlannedTripsInfo();
      if (trips == null) {
        return [];
      } else {
        for (TripInfo trip in trips) {
          addTrip(trip);
        }
        return categorizeTrips(timeline);
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  List<TripInfo> categorizeTrips(String timeline) {
    DateTime now = DateTime.now();
    pastTrips.clear();
    plannedTrips.clear();

    List<TripInfo> allTrips = sortTrips();

    for (TripInfo trip in allTrips) {
      DateTime tripDate = DateFormat('yyyy-MM-dd').parse(trip.departureDate);
      if (tripDate.isBefore(now)) {
        pastTrips.add(trip);
      } else {
        plannedTrips.add(trip);
      }
    }
    if (timeline == Timeline.future) {
      return plannedTrips;
    } else {
      return pastTrips;
    }
  }

  List<TripInfo> sortTrips() {
    List<TripInfo> allTrips = tripsBox.values.toList();

    allTrips.sort((a, b) {
      DateTime aDate = DateFormat('yyyy-MM-dd').parse(a.departureDate);
      DateTime bDate = DateFormat('yyyy-MM-dd').parse(b.departureDate);
      return aDate.compareTo(bDate);
    });
    return allTrips;
  }

  Future<void> addTrip(TripInfo trip) async {
    print(trip.tripId);
    await tripsBox.put(trip.tripId, trip);
  }

  void _updateControllers(Trip? trip) {
    if (trip != null) {
      destinationName.text = trip.destination.text;
      startDateController.text = FormatDate.getformatDate(trip.departureDate);
      endDateController.text = FormatDate.getformatDate(trip.returnDate);
    }
  }
}
