import 'package:easypack/models/trip.dart';
import 'package:easypack/services/trip_service.dart';
import 'package:flutter/material.dart';

class TripDetailsProvider extends ChangeNotifier {
  final TripService _tripService = TripService();
  TextEditingController destinationName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isLoading = false;
  Trip? cachedTrip;
  String? cachedDestinationUrl;
  bool hasUpcomingTrip = false;


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

  void _updateControllers(Trip? trip) {
    if (trip != null) {
      destinationName.text = trip.destination.text;
      startDateController.text = trip.departureDate;
      endDateController.text = trip.returnDate;
    }
  }

  void clearCache() {
    cachedTrip = null;
    notifyListeners();
  }
}
