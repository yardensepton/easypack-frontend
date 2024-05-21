import 'dart:async';
import 'package:easypack/services/user_api_service.dart';
import 'package:flutter/material.dart';
import 'package:easypack/services/city_photo_service.dart';
import 'package:easypack/services/city_search_service.dart';
import 'package:easypack/services/create_user_service.dart';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/navigation_menu.dart';

class CreateUserViewModel {
  final BuildContext context;
  Timer? _debounce;
  final CitySearchService _cityService = CitySearchService();
  final UserCreationService _userCreationService;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  City? selectedCity;
  List<City> autocompleteResults = [];
  final CityPhotoService _cityPhotoService = CityPhotoService();

  String? nameError;
  String? emailError;
  String? residenceError;

  CreateUserViewModel(this.context)
      : _userCreationService = UserCreationService(UserAPIService());

  bool get isAnyTextFieldEmpty =>
      nameController.text.isEmpty ||
      emailController.text.isEmpty ||
      genderController.text.isEmpty ||
      searchController.text.isEmpty;

  void onSearchChanged(String input) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchAutocompleteResults(input);
    });
  }

  void fetchAutocompleteResults(String input) async {
    if (input.isEmpty) {
      autocompleteResults.clear();
      errorsCreateUser();
      return;
    }

    try {
      List<City> results = await _cityService.fetchAutocompleteResults(input);
      autocompleteResults = results;
    } catch (e) {
      Exception('Error fetching autocomplete results: $e');
    }
  }

  void fetchAndShowPhoto(BuildContext context, String placeId) async {
    try {
      String photoUrl = await _cityPhotoService.fetchPhotoResult(placeId);
      Uri uri = Uri.parse(photoUrl);
      final String formattedUrl = uri.toString();
      selectedCity!.cityUrl = formattedUrl;
    } catch (e) {
      Exception('Error fetching and showing photo: $e');
    }
  }

  void errorsCreateUser() {
    nameError = nameController.text.isEmpty ? "Name can't be empty" : null;
    emailError = emailController.text.isEmpty ? "Email can't be empty" : null;
    residenceError = searchController.text.isEmpty ? "Residence can't be empty" : null;

    if (nameController.text.isEmpty || emailController.text.isEmpty || searchController.text.isEmpty) {
      return;
    }
  }

  Future<void> onClickCreateUser() async {
    errorsCreateUser();
    if (selectedCity != null) {
      User? createdUser = await _userCreationService.createUser(
        nameController: nameController,
        emailController: emailController,
        genderController: genderController,
        selectedCity: selectedCity!,
        context: context,
      );

if(!context.mounted) return;
      if (createdUser != null) {
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavigationMenu()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("choose a city")),
      );
    }
  }
}
