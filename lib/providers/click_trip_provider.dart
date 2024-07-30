import 'package:easypack/models/trip.dart';
import 'package:easypack/services/trip_service.dart';
import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';

class ClickTripProvider extends ChangeNotifier {
  final TripService _tripService = TripService();
  Trip? clickedTrip;
  TextEditingController destinationName = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
    String? clickDestinationUrl;

  bool isLoading = false;

  Future<void> fetchTripByID(String tripId) async {
    try {
      isLoading = true;

      clickedTrip = await _tripService.getTripById(tripId);
      if (clickedTrip != null) {
        clickDestinationUrl = clickedTrip?.destination.cityUrl;
        _updateControllers(clickedTrip);
        
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      throw Exception('$e');
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
