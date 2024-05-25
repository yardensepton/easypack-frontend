import 'package:easypack/widgets/auto_complete_field.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/utils/validators.dart';
import 'package:easypack/widgets/input_field.dart';
import 'package:easypack/widgets/gender_toggle_button.dart';
import 'package:line_icons/line_icons.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: const Text('Create User'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: 500.0,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<CreateUserProvider>(
                      builder: (context, userProvider, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 500.0,
                              child: InputField(
                                controller: userProvider.nameController,
                                labelText: 'Name',
                                icon: LineIcons.user,
                                inputType: TextInputType.name,
                                validator: (value) =>
                                    Validators.validateNotEmpty(value, 'Name'),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: 500.0,
                              child: InputField(
                                controller: userProvider.emailController,
                                labelText: 'Email',
                                icon: LineIcons.envelope,
                                inputType: TextInputType.emailAddress,
                                validator: (value) =>
                                    Validators.validateEmailPattern(value),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: 500.0,
                              child: GenderToggleButton(
                                onChanged: (gender) {
                                  userProvider.genderController.text = gender;
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const SizedBox(
                      width: 500.0,
                      child: AutoCompleteField(),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 500.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Provider.of<CreateUserProvider>(context, listen: false)
                                .createUser(
                              context,
                              formKey,
                              Provider.of<AutoCompleteProvider>(context,
                                      listen: false)
                                  .selectedCity,
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 18, 94, 156),
                        ),
                        child: const Text("Create User"),
                      ),
                    ),
                      if (Provider.of<CreateUserProvider>(context).isLoading)
                      const LoadingWidget(),
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
