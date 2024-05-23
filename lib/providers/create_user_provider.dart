import 'dart:async';
import 'package:easypack/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/services/user_api_service.dart';

class CreateUserProvider with ChangeNotifier {
  final UserAPIService _userAPIService = UserAPIService();

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    super.dispose();
  }

  Future<void> createUser(
      BuildContext context, GlobalKey<FormState> formKey, City? selectedCity) async {
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
