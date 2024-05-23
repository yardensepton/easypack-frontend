// import 'package:easypack/providers/auto_complete_provider.dart';
// import 'package:easypack/utils/validators.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:easypack/providers/create_user_provider.dart';
// import 'package:easypack/widgets/city_list_item.dart';
// import 'package:easypack/widgets/input_field.dart';
// import 'package:easypack/widgets/gender_toggle_button.dart';
// import 'package:line_icons/line_icons.dart';

// class CreateUserScreen extends StatelessWidget {
//   const CreateUserScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     final scaffoldKey = GlobalKey<ScaffoldState>();

//     return SafeArea(
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Colors.grey[300],
//         appBar: AppBar(
//           backgroundColor: Colors.grey[300],
//           title: const Text('Create User'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Form(
//                 key: formKey,
//                 child: Consumer<CreateUserProvider>(
//                   builder: (context, userProvider, child) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 500.0,
//                           child: InputField(
//                               controller: userProvider.nameController,
//                               labelText: 'Name',
//                               icon: LineIcons.user,
//                               inputType: TextInputType.name,
//                               validator: (value) =>
//                                   Validators.validateNotEmpty(value, 'Name')),
//                         ),
//                         const SizedBox(height: 16.0),
//                         SizedBox(
//                           width: 500.0,
//                           child: InputField(
//                               controller: userProvider.emailController,
//                               labelText: 'Email',
//                               icon: LineIcons.envelope,
//                               inputType: TextInputType.emailAddress,
//                               validator: (value) =>
//                                   Validators.validateEmailPattern(value)),
//                         ),
//                         const SizedBox(height: 16.0),
//                         SizedBox(
//                           width: 500.0,
//                           child: GenderToggleButton(
//                             onChanged: (gender) {
//                               userProvider.genderController.text = gender;
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
              
//                         const SizedBox(height: 16.0),
//                         Consumer<AutoCompleteProvider>(builder:(context, autoCompleteProvider, child){
//                              SizedBox(
//                           width: 500.0,
//                           child: InputField(
//                             controller: autoCompleteProvider.searchController,
//                             labelText: 'Residence',
//                             icon: LineIcons.city,
//                             inputType: TextInputType.text,
//                             validator: (value) =>
//                                 Validators.validateNotEmpty(value, 'Residence'),
//                             onChanged: autoCompleteProvider.onSearchChanged,
//                           ),
//                         );
//                         const SizedBox(height: 16.0);
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: autoCompleteProvider.autocompleteResults.length,
//                             itemBuilder: (context, index) {
//                               return CityListItem(
//                                 cityName: autoCompleteProvider.autocompleteResults[index].text,
//                                 placeId:
//                                     autoCompleteProvider.autocompleteResults[index].placeId,
//                                 onTap: (placeId) {
//                                   autoCompleteProvider.searchController.text =
//                                       autoCompleteProvider.autocompleteResults[index].text;
//                                   autoCompleteProvider.selectedCity =
//                                       autoCompleteProvider.autocompleteResults[index];
//                                   autoCompleteProvider.fetchAndShowPhoto(context, placeId);
//                                   autoCompleteProvider.autocompleteResults.clear();
//                                 },
//                               );
//                             },
//                           ),
//                         );
                          
//                         }
//                         ,),
                     
//                         const SizedBox(height: 16.0),
//                         SizedBox(
//                           child: TextButton(
//                             onPressed: () {
//                               if (formKey.currentState!.validate()) {
//                                 provider.createUser(context, formKey);
//                               }
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor: Colors.white,
//                               backgroundColor:
//                                   const Color.fromARGB(255, 18, 94, 156),
//                             ),
//                             child: const Text("Create User"),
//                           ),
//                         ),
//                       ],
//                     ),
//             ],
//           );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:easypack/models/city.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/widgets/city_list_item.dart';
import 'package:easypack/widgets/input_field.dart';
import 'package:easypack/widgets/gender_toggle_button.dart';
import 'package:line_icons/line_icons.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    City? selectedCity;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<CreateUserProvider>(
                  builder: (context, userProvider, child) {
                    return Column(
                      children: [
                        InputField(
                          controller: userProvider.nameController,
                          labelText: 'Name',
                          icon: LineIcons.user,
                          inputType: TextInputType.name,
                          validator: (value) => Validators.validateNotEmpty(value, 'Name'),
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: userProvider.emailController,
                          labelText: 'Email',
                          icon: LineIcons.envelope,
                          inputType: TextInputType.emailAddress,
                          validator: (value) => Validators.validateEmailPattern(value),
                        ),
                        const SizedBox(height: 16.0),
                        GenderToggleButton(
                          onChanged: (gender) {
                            userProvider.genderController.text = gender;
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                Consumer<AutoCompleteProvider>(
                  builder: (context, autoCompleteProvider, child) {
                    return Column(
                      children: [
                        InputField(
                          controller: autoCompleteProvider.searchController,
                          labelText: 'Residence',
                          icon: LineIcons.city,
                          inputType: TextInputType.text,
                          validator: (value) => Validators.validateNotEmpty(value, 'Residence'),
                          onChanged: autoCompleteProvider.onSearchChanged,
                        ),
                        const SizedBox(height: 16.0),
                        ListView.builder(
                          shrinkWrap: true, // Set shrinkWrap to true
                          itemCount: autoCompleteProvider.autocompleteResults.length,
                          itemBuilder: (context, index) {
                            return CityListItem(
                              cityName: autoCompleteProvider.autocompleteResults[index].text,
                              placeId: autoCompleteProvider.autocompleteResults[index].placeId,
                              onTap: (placeId) {
                                autoCompleteProvider.searchController.text = autoCompleteProvider.autocompleteResults[index].text;
                                autoCompleteProvider.selectedCity = autoCompleteProvider.autocompleteResults[index];
                                selectedCity = autoCompleteProvider.autocompleteResults[index];
                                autoCompleteProvider.fetchAndShowPhoto(context, placeId);
                                autoCompleteProvider.autocompleteResults.clear();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Provider.of<CreateUserProvider>(context, listen: false).createUser(context, formKey,selectedCity);
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 18, 94, 156),
                  ),
                  child: const Text("Create User"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

