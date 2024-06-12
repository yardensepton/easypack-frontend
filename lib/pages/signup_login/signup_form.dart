import 'package:easypack/pages/signup_login/sign_up_login_screen.dart';
import 'package:easypack/utils/validators.dart';
import 'package:easypack/widgets/auto_complete_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/widgets/gender_toggle_button.dart';
import 'package:easypack/providers/auto_complete_provider.dart';

class SignUpForm extends StatefulWidget {
  final SignupData data;

  const SignUpForm({super.key, required this.data});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 350,
          height: 600,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Please fill in this form to complete the signup',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 116, 111, 111),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Consumer<CreateUserProvider>(
                      builder: (context, userProvider, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_outline,
                                    color: Colors.grey),
                                labelText: "Name",
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              controller: userProvider.nameController,
                              validator: (value) =>
                                  Validators.validateNotEmpty(value, 'Name'),
                            ),
                            const SizedBox(height: 15),
                            GenderToggleButton(
                              onChanged: (gender) {
                                userProvider.genderController.text = gender;
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(
                      width: 350.0,
                      child: AutoCompleteField(),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,                     
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpLoginScreen(),
                              ),
                            ); // Return null when 'BACK' is pressed
                          },
                          child: const Text(
                            'BACK',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<CreateUserProvider>(context,
                                      listen: false)
                                  .createUser(
                                      context,
                                      _formKey,
                                      Provider.of<AutoCompleteProvider>(context,
                                              listen: false)
                                          .selectedCity,
                                      widget.data);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'SUBMIT',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
