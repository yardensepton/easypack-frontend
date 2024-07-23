import 'dart:async';
import 'package:easypack/models/city.dart';
import 'package:easypack/services/city_search_service.dart';
import 'package:flutter/material.dart';

class AutoCompleteProvider with ChangeNotifier {
  final CitySearchService _cityService = CitySearchService();

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
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (input.isEmpty) {
        autocompleteResults.clear();
      } else {
        fetchAutocompleteResults(input);
      }
      clearResultsBeforeNewSearch();
    });
  }

  Future<void> fetchAutocompleteResults(String input) async {
    try {
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

}
