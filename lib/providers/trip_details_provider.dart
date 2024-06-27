import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/trip.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/services/trip_service.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TripDetailsProvider extends ChangeNotifier {
  final TripService _tripService = TripService();
  TextEditingController destinationName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  Box<Map> tripsBox = Hive.box(Boxes.tripsBox);
  bool isLoading = false;
  Trip? cachedTrip;
  String? cachedDestinationUrl;
  List<TripInfo>? plannedTrips;
  List<TripInfo>? pastTrips;
  bool hasUpcomingTrip = false;
  bool hasPlannedTrips = false;
  bool hasPastTrips = false;

  void reset() {
    tripsBox.clear();
    cachedTrip = null;
    isLoading = false;
    cachedDestinationUrl = null;
    hasUpcomingTrip = false;
    notifyListeners();
  }

  void connectToWebSocket() {
    _tripService.listenToChanges(
      (message) {
        _handleWebSocketMessage(message);
      },
      (error) {
        print('WebSocket error: $error');
        // Optionally handle error (e.g., reconnect or show error message)
      },
      () {
        print('WebSocket connection closed');

        // Optionally handle closed connection (e.g., reconnect or cleanup)
      },
    );
  }


//todo - because of the await the loading takes a lot time maybe add a loading widget
  void _handleWebSocketMessage(String message) async {
    print('Received message: $message');
    await fetchPlannedTrips(forceRefresh: true, Timeline.future);
    await fetchPlannedTrips(forceRefresh: true, Timeline.past);
    await fetchUpcomingTrip(forceRefresh: true);
    notifyListeners();
  }

  Future<void> fetchUpcomingTrip({bool forceRefresh = false}) async {
    if (cachedTrip == null || forceRefresh == true) {
      try {
        isLoading = true;
        cachedTrip = await _tripService.getTripById(plannedTrips!.first.tripId);
        if (cachedTrip != null) {
          hasUpcomingTrip = true;
          _updateControllers(cachedTrip);
          cachedDestinationUrl = cachedTrip?.destination.cityUrl;
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
  }

  Future<void> deleteTripById(String tripId) async {
    try {
      isLoading = true;
      await _tripService.deleteTripById(tripId);
      isLoading = false;
      // notifyListeners();
    } catch (e) {
      isLoading = false;
      throw Exception('$e');
    }
  }



  Future<List<TripInfo>?> fetchPlannedTrips(String timeline,
      {bool forceRefresh = false}) async {
    final cacheKey = 'plannedTrips_$timeline';

    if (!forceRefresh & tripsBox.containsKey(cacheKey)) {
      print("Using cached data for $cacheKey");
      Map tripsMap = tripsBox.get(cacheKey) as Map;
      List<TripInfo> trips = List<TripInfo>.from(tripsMap[cacheKey]);
      if (timeline == Timeline.future) {
        hasPlannedTrips = true;
        plannedTrips = trips;
      } else if (timeline == Timeline.past) {
        hasPastTrips = true;
        pastTrips = trips;
      }
      return trips;
    }
    try {
      isLoading = true;
      if (timeline == Timeline.future) {
        plannedTrips = await _tripService.getPlannedTripsInfo(timeline);
        if (plannedTrips != null) {
          hasPlannedTrips = true;
          await tripsBox.put(cacheKey, {cacheKey: plannedTrips});
          return plannedTrips;
        } else {
          hasPlannedTrips = false;
          return [];
        }
      } else if (timeline == Timeline.past) {
        pastTrips = await _tripService.getPlannedTripsInfo(timeline);
        if (pastTrips != null) {
          hasPastTrips = true;
          await tripsBox.put(cacheKey, {cacheKey: pastTrips});
          return pastTrips;
        } else {
          hasPastTrips = false;
          return [];
        }
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      throw Exception('$e');
    }
    return null;
  }

  void pastOrFutureTrips(
      String timeline, List<TripInfo>? trips, bool hasTrips) async {
    trips = await _tripService.getPlannedTripsInfo(timeline);
    if (trips != null) {
      hasTrips = true;
    } else {
      hasTrips = false;
    }
  }

  void _updateControllers(Trip? trip) {
    if (trip != null) {
      destinationName.text = trip.destination.text;
      startDateController.text = FormatDate.getformatDate(trip.departureDate);
      endDateController.text = FormatDate.getformatDate(trip.returnDate);
    }
  }
}
