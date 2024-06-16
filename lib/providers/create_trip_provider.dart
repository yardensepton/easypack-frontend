import 'package:easypack/services/trip_service.dart';
import 'package:flutter/material.dart';

class CreateTripProvider with ChangeNotifier{
  final TripService tripAPIService = TripService();
  final TextEditingController destinationController = TextEditingController();




  //   Future<void> createUser(
  //     BuildContext context, GlobalKey<FormState> formKey) async {
  //   if (selectedCity != null) {
  //     final String name = nameController.text;
  //     final String email = emailController.text;
  //     final String gender = genderController.text;

  //     try {
  //       User? createdUser = await _userAPIService.createUser(
  //         name: name,
  //         email: email,
  //         gender: gender,
  //         city: selectedCity!,
  //       );

  //       if (createdUser != null) {
  //         if (context.mounted) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('User created successfully!')),
  //           );
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => const NavigationMenu()),
  //           );
  //         }
  //       }
  //     } catch (e) {
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("$e")),
  //         );
  //       }
  //     }
  //   }
  //   if (selectedCity == null) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Choose a city')),
  //       );
  //     }
  //   }
  // }
}