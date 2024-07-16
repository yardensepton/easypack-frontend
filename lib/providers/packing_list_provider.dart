import 'package:easypack/models/packing_list.dart';
import 'package:easypack/services/packing_list_service.dart';
import 'package:easypack/widgets/snack_bars/error_snack_bar.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';

class PackingListProvider with ChangeNotifier {
  final PackingListService packingListService = PackingListService();
  final TextEditingController tripTypeController = TextEditingController();
  Set<String> _selectedSpecialItems = {};
  Set<String> _selectedActivites = {};
  bool isLoading = false;
  PackingList? currentPackingList;

  Set<String> get selectedSpecialItems => _selectedSpecialItems;

  Set<String> get selectedActivites => _selectedActivites;

  void addSpecialItem(String item) {
    _selectedSpecialItems.add(item);
    notifyListeners();
  }

  void removeSpecialItem(String item) {
    _selectedSpecialItems.remove(item);
    notifyListeners();
  }

  void addAcivity(String item) {
    _selectedActivites.add(item);
    notifyListeners();
  }

  void removeActivity(String item) {
    _selectedActivites.remove(item);
    notifyListeners();
  }

  Future<void> ceatePackingList(BuildContext context, String tripId) async {
    if (tripId.isNotEmpty) {
      isLoading = true;
      notifyListeners();
      String? response =
          await packingListService.createPackingList(tripId: tripId);
      if (context.mounted) {
        if (response == null) {
          SuccessSnackBar.showSuccessSnackBar(
              context, "Packing list created successfuly!");
          notifyListeners();
        } else {
          ErrorSnackBar.showErrorSnackBar(context, response);
        }
      }
    } else {
      if (context.mounted) {
        ErrorSnackBar.showErrorSnackBar(context, "Problem");
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<PackingList?> getPackingList(String tripId) async {
    if (tripId.isNotEmpty) {
      currentPackingList =  await packingListService.getPackingList(tripId: tripId);
      return currentPackingList;
    }
    return null;
  }

  bool hasPackingList(String tripId) {
    return currentPackingList != null;
  }

  // void _updateControllers(PackingList packingList) {
  //   destinationName.text = trip.destination.text;
  //   startDateController.text = FormatDate.getformatDate(trip.departureDate);
  //   endDateController.text = FormatDate.getformatDate(trip.returnDate);
  // }
}
