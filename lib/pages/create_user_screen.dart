import 'package:easypack/models/city.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/services/city_photo_service.dart';
import 'package:easypack/services/user_api_service.dart';
import 'package:easypack/widgets/city_list_item.dart';
import 'package:easypack/widgets/input_field.dart';
import 'package:easypack/widgets/gender_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:easypack/services/city_search_service.dart';
import 'package:easypack/services/create_user_service.dart';
import 'package:easypack/navigation_menu.dart';
// import 'package:easypack/pages/home_user.dart';

import 'dart:async';
// import 'package:easypack/models/user.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() {
    return _CreateUserScreenState();
  }
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  Timer? _debounce;
  final CitySearchService _cityService = CitySearchService();
  final UserCreationService _userCreationService = UserCreationService( UserAPIService());
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  City? _selectedCity;
  List<City> _autocompleteResults = [];

  final CityPhotoService _cityPhotoService = CityPhotoService();

  String? _nameError;
  String? _emailError;
  String? _residenceError;

  _onSearchChanged(String input) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchAutocompleteResults(input);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _fetchAutocompleteResults(String input) async {
    if (input.isEmpty) {
      setState(() {
        _autocompleteResults.clear();
        _errorsCreateUser();

      });
      return;
    }

    try {
      List<City> results = await _cityService.fetchAutocompleteResults(input);
      setState(() {
        _autocompleteResults = results;
      });
    } catch (e) {
      Exception('Error fetching autocomplete results: $e');
    }
  }

  void _fetchAndShowPhoto(BuildContext context, String placeId) async {
    try {
      String photoUrl = await _cityPhotoService.fetchPhotoResult(placeId);
      Uri uri = Uri.parse(photoUrl);
      final String formattedUrl = uri.toString();
      
      _selectedCity!.cityUrl = formattedUrl;
      
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('City Photo'),
    //         content: Image.network(
    //           formattedUrl,
    //           fit: BoxFit.cover,
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('Close'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    } catch (e) {
      // Handle errors
      Exception('Error fetching and showing photo: $e');
    }
  }

    bool get isAnyTextFieldEmpty =>
      _nameController.text.isEmpty ||
      _emailController.text.isEmpty ||
      _genderController.text.isEmpty ||
      _searchController.text.isEmpty;

  void _errorsCreateUser() async {
    setState(() {
      _nameError = _nameController.text.isEmpty ? "Name can't be empty" : null;
      _emailError = _emailController.text.isEmpty ? "Email can't be empty" : null;
      _residenceError = _searchController.text.isEmpty ? "Residence can't be empty" : null;

    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _searchController.text.isEmpty ) {
      return;
    }
    });

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 246, 246),
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 249, 246, 246),
        title: const Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 500.0,
              child: InputField(
                controller: _nameController,
                labelText: 'Enter your name',
                icon: Icons.person,
                inputType: TextInputType.name,
                errorText: _nameError,
                 onChanged: (value) {
                  _errorsCreateUser();
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 500.0,
              child: InputField(
                controller: _emailController,
                labelText: 'Enter your email',
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
                errorText: _emailError,
                onChanged: (value) {
                  _errorsCreateUser();
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 500.0,
              child:    GenderToggleButton(
            onChanged: (gender) {
              _errorsCreateUser();
             _genderController.text = gender;
  },
),
       
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 500.0,
              child: InputField(
                controller: _searchController,
                labelText: 'Enter your residence',
                icon: Icons.location_city_outlined,
                inputType: TextInputType.text,
                onChanged: (value) {
                  _onSearchChanged(value);
                  _errorsCreateUser();
                },
                errorText: _residenceError,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _autocompleteResults.length,
                itemBuilder: (context, index) {
                  return CityListItem(
                    cityName: _autocompleteResults[index].text,
                    placeId: _autocompleteResults[index].placeId,
                    onTap: (placeId) {
                      setState(() {
                        _searchController.text =
                          _autocompleteResults[index].text;
                          _selectedCity = _autocompleteResults[index];
                        _fetchAndShowPhoto(context, placeId);
                        _autocompleteResults.clear();
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              child: TextButton(
                  onPressed: isAnyTextFieldEmpty ? null : onClickCreateUser,
              style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:const Color.fromARGB(255, 18, 94, 156),
      ),
                // onPressed: _createUser,
                child: const Text("Create User",),
                
              ),
            ),
          ],
        ),
      ),
    ));
  }

 Future<void> onClickCreateUser() async {
    _errorsCreateUser();
    if (_selectedCity != null) {
      User? createdUser = 
     await _userCreationService.createUser(
        nameController: _nameController,
        emailController: _emailController,
        genderController: _genderController,
        selectedCity: _selectedCity!,
        context: context
      );

 if (!mounted) return;
       if(createdUser != null){
               Navigator.push(context,
      MaterialPageRoute(builder: (context) => const NavigationMenu()),
        );
      }


    } else {
     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          content: Text("choose a city")));

      
  
    }
 }
}


