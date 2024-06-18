import 'package:easypack/models/city.dart';
import 'package:easypack/services/trip_service.dart';
import 'package:easypack/widgets/snack_bars/error_snack_bar.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';

class CreateTripProvider with ChangeNotifier {
  final TripService _tripAPIService = TripService();


  Future<void> createTrip(BuildContext context,
      City? selectedCity, String startDate,String endDate) async {
    if (selectedCity != null ) {
      String? response = await _tripAPIService.creatTrip(
        destination: selectedCity,
        departureDate: startDate,
        returnDate: endDate,

      );

      if (context.mounted) {
        if (response == null) {
          SuccessSnackBar.showSuccessSnackBar(
              context, "Trip created successfuly!");
          // nameController.clear();
          selectedCity = null;
        } else {
          ErrorSnackBar.showErrorSnackBar(context, response);
        }
      }
    } else {
      if (context.mounted) {
        ErrorSnackBar.showErrorSnackBar(context, "Choose a city");
      }
    }
  }

}
