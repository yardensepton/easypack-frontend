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

  Future<void> fetchUpcomingTrip({bool forceRefresh = false}) async {
    if (cachedTrip != null && !forceRefresh) {
      _updateControllers(cachedTrip);
      return;
    }

    try {
      isLoading = true;
      notifyListeners();
      Trip? trip = await _tripService.getClosestUpcomingTrip();
      if (trip != null) {
        _updateControllers(trip);
        cachedDestinationUrl = trip.destination.cityUrl;
      } else {
        destinationName.text = '';
        startDateController.text = '';
        endDateController.text = '';
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception('$e');
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
