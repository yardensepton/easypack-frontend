import 'package:easypack/services/user_api_service.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/models/city.dart';
import 'package:flutter/material.dart';

class UserCreationService {
  final UserAPIService _userAPIService;

  UserCreationService(this._userAPIService);

  Future<User?> createUser({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController genderController,
    required City selectedCity,
    required BuildContext context, 
  })
  
   async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String gender = genderController.text;
    final City city = selectedCity;

    final newUser = User(
      name: name,
      email: email,
      gender: gender,
      city: city,
    );

    try {

      final createdUser = await _userAPIService.createUser(newUser);

      if (createdUser != null) {
        if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User created successfully!'),
        ));
        }
        return createdUser;
      }
    } catch (e) {
       if (context.mounted){
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('$e'),
        ));
       }

    }
    return null;
  }
}
