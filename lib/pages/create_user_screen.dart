import 'package:easypack/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/widgets/city_list_item.dart';
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
          child: Form(
            key: formKey,
            child: Consumer<CreateUserProvider>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 500.0,
                      child: InputField(
                          controller: provider.nameController,
                          labelText: 'Enter your name',
                          icon: LineIcons.user,
                          inputType: TextInputType.name,
                          validator: (value) =>
                              Validators.validateNotEmpty(value, 'Name')),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 500.0,
                      child: InputField(
                          controller: provider.emailController,
                          labelText: 'Enter your email',
                          icon: LineIcons.envelope,
                          inputType: TextInputType.emailAddress,
                          validator: (value) =>
                              Validators.validateNotEmpty(value, 'Email')),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 500.0,
                      child: GenderToggleButton(
                        onChanged: (gender) {
                          provider.genderController.text = gender;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 500.0,
                      child: InputField(
                        controller: provider.searchController,
                        labelText: 'Enter your residence',
                        icon: LineIcons.city,
                        inputType: TextInputType.text,
                        validator: (value) =>
                            Validators.validateNotEmpty(value, 'Residence'),
                        onChanged: provider.onSearchChanged,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.autocompleteResults.length,
                        itemBuilder: (context, index) {
                          return CityListItem(
                            cityName: provider.autocompleteResults[index].text,
                            placeId:
                                provider.autocompleteResults[index].placeId,
                            onTap: (placeId) {
                              provider.searchController.text =
                                  provider.autocompleteResults[index].text;
                              provider.selectedCity =
                                  provider.autocompleteResults[index];
                              provider.fetchAndShowPhoto(context, placeId);
                              provider.autocompleteResults.clear();
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            provider.createUser(context, formKey);
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 18, 94, 156),
                        ),
                        child: const Text("Create User"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
