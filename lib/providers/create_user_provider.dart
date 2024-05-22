import 'dart:async';

import 'package:easypack/exception/server_exception.dart';
import 'package:easypack/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/services/city_photo_service.dart';
import 'package:easypack/services/city_search_service.dart';
import 'package:easypack/services/user_api_service.dart';

class CreateUserProvider with ChangeNotifier {
  final CitySearchService _cityService = CitySearchService();
  final UserAPIService _userAPIService = UserAPIService();
  final CityPhotoService _cityPhotoService = CityPhotoService();

  Timer? _debounce;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  City? selectedCity;
  List<City> autocompleteResults = [];

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    super.dispose();
  }

  void onSearchChanged(String input) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchAutocompleteResults(input);
    });
  }

  Future<void> fetchAutocompleteResults(String input) async {
    if (input.isEmpty) {
      autocompleteResults.clear();
      notifyListeners();
      return;
    }

    try {
      List<City> results = await _cityService.fetchAutocompleteResults(input);
      autocompleteResults = results;
      notifyListeners();
    } catch (e) {
      throw ServerException('$e');
    }
  }

  Future<void> fetchAndShowPhoto(BuildContext context, String placeId) async {
    try {
      String photoUrl = await _cityPhotoService.fetchPhotoResult(placeId);
      Uri uri = Uri.parse(photoUrl);
      final String formattedUrl = uri.toString();
      selectedCity?.cityUrl = formattedUrl;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$e")),
        );
      }
    }
  }

  Future<void> createUser(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (selectedCity != null) {
      final String name = nameController.text;
      final String email = emailController.text;
      final String gender = genderController.text;

      try {
        User? createdUser = await _userAPIService.createUser(
          name: name,
          email: email,
          gender: gender,
          city: selectedCity!,
        );

        if (createdUser != null) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User created successfully!')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavigationMenu()),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$e")),
          );
        }
      }
    }
    if (selectedCity == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Choose a city')),
        );
      }
    }
  }
}
