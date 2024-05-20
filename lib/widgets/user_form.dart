import 'package:easypack/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController genderController;

  const UserForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.genderController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
RoundedInputField(
    textEditingController:  emailController,
    hintText: "Your Email",
    icon: Icons.email,
    cursorColor: Colors.black,
    editTextBackgroundColor:const Color.fromARGB(255, 220, 209, 209),
    iconColor: Colors.black,
    onChanged: (value) {
      // e = value;
     },
 )



        // const Text('Name'),
        // TextFormField(controller: nameController),
        // const SizedBox(height: 16),
        // const Text('Email'),
        // TextFormField(controller: emailController),
        // const SizedBox(height: 16),
        // const Text('Gender'),
        // TextFormField(controller: genderController),
      ],
    );
  }
}
