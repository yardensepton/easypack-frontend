import 'dart:async';
import 'package:easypack/models/city.dart';
import 'package:easypack/pages/signup_login/sign_up_login_screen.dart';
import 'package:easypack/widgets/snack_bars/error_snack_bar.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:easypack/services/user_service.dart';
import 'package:flutter_login/flutter_login.dart';

class CreateUserProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
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

      String? response = await UserService().createUser(
        name: name,
        password: password,
        email: email,
        role: role,
        gender: gender,
        city: selectedCity,
      );

      if (context.mounted) {
        if (response == null) {
          SuccessSnackBar.showSuccessSnackBar(
              context, "User created successfuly!\nplease login");
          nameController.clear();
          selectedCity = null;
          moveToLoginScreen(context);
        } else {
          ErrorSnackBar.showErrorSnackBar(context, response);
        }
      }
    } else {
      if (context.mounted) {
        ErrorSnackBar.showErrorSnackBar(context, "Choose a city");
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void moveToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpLoginScreen(),
      ),
    );
  }
}
