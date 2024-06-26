import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/trip.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/services/trip_service.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';

class TripDetailsProvider extends ChangeNotifier {
  final TripService _tripService = TripService();
  TextEditingController destinationName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isLoading = false;
  Trip? cachedTrip;
  String? cachedDestinationUrl;
  List<TripInfo>? plannedTrips;
  List<TripInfo>? pastTrips;
  bool hasUpcomingTrip = false;
  bool hasPlannedTrips = false;
  bool hasPastTrips = false;

  void reset() {
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

  void _handleWebSocketMessage(String message) {
    print('Received message: $message');
    fetchUpcomingTrip(forceRefresh: true);
  }

  Future<void> fetchUpcomingTrip({bool forceRefresh = false}) async {
    if (cachedTrip == null || forceRefresh == true) {
      try {
        isLoading = true;
        cachedTrip = await _tripService.getClosestUpcomingTrip();
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

  Future<List<TripInfo>?> fetchPlannedTrips(String timeline,
      {bool forceRefresh = true}) async {
    if (forceRefresh == true) {
      try {
        isLoading = true;
        if (timeline == Timeline.future) {
          plannedTrips = await _tripService.getPlannedTripsInfo(timeline);
          if (plannedTrips != null) {
            hasPlannedTrips = true;
            return plannedTrips;
          } else {
            hasPlannedTrips = false;
             return [];
          }
        } else if (timeline == Timeline.past) {
           pastTrips = await _tripService.getPlannedTripsInfo(timeline);
          if (pastTrips != null) {
            hasPastTrips = true;
             return pastTrips;
          } else {
            hasPastTrips = false;
             return [];
          }
        }
        // for (TripInfo trip in plannedTrips!) {
        //   print(trip);

        isLoading = false;
      } catch (e) {
        isLoading = false;
        throw Exception('$e');
      }
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

  //   void _updateTripCard(Trip? trip) {
  //   if (trip != null) {
  //     destinationName.text = trip.destination.text;
  //     startDateController.text = trip.departureDate;
  //     endDateController.text = trip.returnDate;
  //   }
  // }

  void clearCache() {
    cachedTrip = null;
    notifyListeners();
  }
}
