import 'dart:async';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:easypack/services/user_api_service.dart';
import 'package:flutter_login/flutter_login.dart';

class CreateUserProvider with ChangeNotifier {
  final UserAPIService _userAPIService = UserAPIService();

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
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
      City? selectedCity,  SignupData data) async {
    if (selectedCity != null) {
      final String name = nameController.text;
      final String gender = genderController.text;
      final String password = data.password!;
      final String email = data.name!;
      const String role = 'member';

      try {
        isLoading = true;
        notifyListeners(); // Notify listeners to update UI for loading state
        User? createdUser = await _userAPIService.createUser(
          name: name,
          password: password,
          email: email,
          role: role,
          gender: gender,
          city: selectedCity,
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
      } finally {
        isLoading = false;
        notifyListeners();
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Choose a city')),
        );
      }
    }
  }
}
