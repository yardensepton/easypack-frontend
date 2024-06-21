import 'package:easypack/models/city.dart';
import 'package:easypack/services/city_photo_service.dart';
import 'package:easypack/services/trip_service.dart';
import 'package:easypack/widgets/snack_bars/error_snack_bar.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';

class CreateTripProvider with ChangeNotifier {
  final TripService _tripAPIService = TripService();
  final CityPhotoService _cityPhotoService = CityPhotoService();
  bool isLoading = false;

  Future<void> createTrip(BuildContext context, City? selectedCity,
      String startDate, String endDate) async {
    if (selectedCity != null) {
      isLoading = true;
      notifyListeners();
      String? response = await _tripAPIService.creatTrip(
        destination: selectedCity,
        departureDate: startDate,
        returnDate: endDate,
      );

      if (context.mounted) {
        fetchAndShowPhoto(context, selectedCity);
        isLoading = false;
        notifyListeners();
        if (response == null) {
          SuccessSnackBar.showSuccessSnackBar(
              context, "Trip created successfuly!");
          // nameController.clear();
          selectedCity = null;
          notifyListeners();
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

  Future<void> fetchAndShowPhoto(
      BuildContext context, City selectedCity) async {
    try {
      String photoUrl =
          await _cityPhotoService.fetchPhotoResult(selectedCity.placeId);
      Uri uri = Uri.parse(photoUrl);
      final String formattedUrl = uri.toString();
      selectedCity.cityUrl = formattedUrl;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$e")),
        );
      }
    }
  }
}
