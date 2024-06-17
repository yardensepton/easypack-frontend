import 'dart:async';

import 'package:easypack/models/city.dart';
import 'package:easypack/services/city_photo_service.dart';
import 'package:easypack/services/city_search_service.dart';
import 'package:easypack/utils/validators.dart';
import 'package:flutter/material.dart';

class AutoCompleteProvider with ChangeNotifier {
  final CitySearchService _cityService = CitySearchService();
  final CityPhotoService _cityPhotoService = CityPhotoService();

  Timer? _debounce;
  TextEditingController searchController = TextEditingController();
  City? selectedCity;
  List<City> autocompleteResults = [];
  bool isLoading = false;

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged(String input) {
    if (!Validators.isEmptyBool(input)) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        fetchAutocompleteResults(input);
      });
    } else {
      clearResultsBeforeNewSearch();
      // autocompleteResults.clear();
      // selectedCity = null;
      // notifyListeners();
    }
  }

  Future<void> fetchAutocompleteResults(String input) async {
    try {
      // autocompleteResults.clear();
      // selectedCity = null;
      // notifyListeners();
      clearResultsBeforeNewSearch();
      List<City> results = await _cityService.fetchAutocompleteResults(input);
      autocompleteResults = results;
      notifyListeners();
    } catch (e) {
      throw Exception('$e');
    }
  }

  void clearResults() {
    autocompleteResults.clear();
    searchController.clear();
    notifyListeners();
  }
    void clearResultsBeforeNewSearch() {
    autocompleteResults.clear();
    selectedCity = null;
    notifyListeners();
  }

  Future<void> fetchAndShowPhoto(BuildContext context, String placeId) async {
    try {
      isLoading = true;
      notifyListeners();
      String photoUrl = await _cityPhotoService.fetchPhotoResult(placeId);
      Uri uri = Uri.parse(photoUrl);
      final String formattedUrl = uri.toString();
      selectedCity?.cityUrl = formattedUrl;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$e")),
        );
      }
    }
  }
}
