import 'dart:async';
import 'package:easypack/exception/server_error.dart';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/navigation_menu.dart';
import 'package:easypack/widgets/snack_bars/error_snack_bar.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:easypack/services/user_service.dart';
import 'package:flutter_login/flutter_login.dart';

class CreateUserProvider with ChangeNotifier {
  final UserService _userAPIService = UserService();

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  ServerError serverError = ServerError();
  bool isLoading = false;
  User? createdUser;

  @override
  void dispose() {
    searchController.dispose();
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    super.dispose();
  }
  

  Future<void> createUser(BuildContext context, GlobalKey<FormState> formKey,
      City? selectedCity, SignupData data) async {
    if (selectedCity != null) {
      final String name = nameController.text;
      final String gender = genderController.text;
      final String password = data.password!;
      final String email = data.name!;
      const String role = 'member';

      isLoading = true;
      notifyListeners(); // Notify listeners to update UI for loading state

      String? response = await _userAPIService.createUser(
        name: name,
        password: password,
        email: email,
        role: role,
        gender: gender,
        city: selectedCity,
      );

      if (response == null) {
        //if the response is null the user was created
        if (context.mounted) {
          SuccessSnackBar.showSuccessSnackBar(
              context, "User created successfully!");
          // await Future.delayed(const Duration(seconds: 4));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NavigationMenu()),
          );
        }
      } else {
        if (context.mounted) {
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
