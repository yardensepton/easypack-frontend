import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/trip.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/services/trip_service.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class TripDetailsProvider with ChangeNotifier, WidgetsBindingObserver {
  final TripService _tripService = TripService();
  TextEditingController destinationName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  Box<TripInfo> tripsBox = Hive.box(Boxes.tripsBox);
  bool isLoading = false;
  Trip? cachedTrip;
  String? cachedDestinationUrl;
  List<TripInfo> plannedTrips = [];
  List<TripInfo> pastTrips = [];
  bool hasUpcomingTrip = false;

  TripDetailsProvider() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      reset();
    } else if (state == AppLifecycleState.resumed && tripsBox.isEmpty) {
      await fetchPlannedTrips();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void reset() {
    tripsBox.clear();
    cachedTrip = null;
    isLoading = false;
    cachedDestinationUrl = null;
    hasUpcomingTrip = false;
    pastTrips.clear();
    plannedTrips.clear();
    tripsBox.clear();
    notifyListeners();
  }

  bool get hasNoTrips {
    return tripsBox.isEmpty;
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

  Future<String?> deleteTripById(String tripId) async {
    try {
      String? response = await _tripService.deleteTripById(tripId);
      if (response == null) {
        if (tripsBox.containsKey(tripId)) {
          tripsBox.delete(tripId);
          plannedTrips.removeWhere((trip) => trip.tripId == tripId);
          pastTrips.removeWhere((trip) => trip.tripId == tripId);
          notifyListeners();
        }
      }
      return response;
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> fetchPlannedTrips({bool forceRefresh = false}) async {
    print(tripsBox.length);
    if (tripsBox.isNotEmpty) {
      categorizeTrips();
      return;
    }
    try {
      List<TripInfo>? trips = await _tripService.getPlannedTripsInfo();
      if (trips != null) {
        trips.forEach(addTrip);
        categorizeTrips();
      }
    } catch (e) {
      throw Exception('$e');
    }
  }


  void categorizeTrips() {
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
