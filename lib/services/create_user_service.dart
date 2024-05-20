import 'package:easypack/services/user_api_service.dart';
import 'package:easypack/models/user.dart';
import 'package:flutter/material.dart';

class UserCreationService {
  final UserAPIService _userAPIService;

  UserCreationService(this._userAPIService);

  Future<void> createUser({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController genderController,
    required TextEditingController searchController,
    required BuildContext context, 
  })
  
   async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String gender = genderController.text;
    final String residence = searchController.text;

    final newUser = User(
      name: name,
      email: email,
      gender: gender,
      residence: residence,
    );

    try {

      final createdUser = await _userAPIService.createUser(newUser);

      if (createdUser != null) {
        if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User created successfully!'),
        ));
        }

      }
    } catch (e) {
       if (context.mounted){
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('$e'),
        ));
       }

    }
  }
}
