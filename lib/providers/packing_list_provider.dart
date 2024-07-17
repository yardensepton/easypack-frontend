import 'package:easypack/models/item_list.dart';
import 'package:easypack/models/packing_list.dart';
import 'package:easypack/services/packing_list_service.dart';
import 'package:easypack/utils/string_extentsion.dart';
import 'package:easypack/widgets/snack_bars/error_snack_bar.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';

class PackingListProvider with ChangeNotifier {
  final PackingListService packingListService = PackingListService();
  final TextEditingController tripTypeController = TextEditingController();
  List<String> _selectedSpecialItems = [];
  List<String> _selectedActivites = [];
  bool isLoading = false;
  PackingList? currentPackingList;

  List<String> get selectedSpecialItems => _selectedSpecialItems;

  List<String> get selectedActivites => _selectedActivites;

  void addSpecialItem(String item) {
    _selectedSpecialItems.add(item.removeUnderscores().toLowerCase());
    // notifyListeners();
  }

  void removeSpecialItem(String item) {
    _selectedSpecialItems.remove(item.removeUnderscores().toLowerCase());
    // notifyListeners();
  }

  void addAcivity(String item) {
    _selectedActivites.add(item);
    // notifyListeners();
  }

  void removeActivity(String item) {
    _selectedActivites.remove(item);
    // notifyListeners();
  }

  Map<String, List<ItemList>> groupItemsByCategory() {
    Map<String, List<ItemList>> groupedItems = {};

    for (var item in currentPackingList!.items) {
      if (groupedItems.containsKey(item.category)) {
        groupedItems[item.category]!.add(item);
      } else {
        groupedItems[item.category] = [item];
      }
    }
    return groupedItems;
  }


  Future<String?> deletePackingListById(
      BuildContext context, String tripId) async {
    try {
      String? response = await packingListService.deletePackingListById(
        tripId: tripId,
        packingListId: currentPackingList!.id!,
      );
      currentPackingList = null;
      notifyListeners();
      return response;
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> createPackingList(BuildContext context, String tripId) async {
    if (tripId.isNotEmpty) {
      isLoading = true;
      // notifyListeners();
      String? response = await packingListService.createPackingList(
          tripId: tripId,
          items: _selectedSpecialItems,
          activities: _selectedActivites);
      if (context.mounted) {
        if (response == null) {
          SuccessSnackBar.showSuccessSnackBar(
              context, "Packing list created successfuly!");
          Navigator.pop(context);
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

    //notify the trip page to rebuild to show the new packing list
    notifyListeners();
  }

  Future<PackingList?> getPackingList(String tripId) async {
    if (tripId.isNotEmpty) {
      currentPackingList =
          await packingListService.getPackingList(tripId: tripId);
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
