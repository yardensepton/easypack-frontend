import 'package:easypack/models/city.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/widgets/cities_bottom_sheet.dart';
import 'package:easypack/widgets/gender_toggle_button.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/auth_user_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Future<void> _loadUserDataFuture;

  @override
  void initState() {
    super.initState();
    _loadUserDataFuture =
        Provider.of<AuthUserProvider>(context, listen: false).getCurrentUser();
  }

  void _saveChanges(AuthUserProvider authUserProvider) async {
    String name = authUserProvider.userNameUpdate.text;
    City? city =
        Provider.of<AutoCompleteProvider>(context, listen: false).selectedCity;
    String gender = authUserProvider.gender;

    User? user = await authUserProvider.updateCurrentUser(gender, name, city);
    if (user != null) {
      SuccessSnackBar.showSuccessSnackBar(context, "Changes saved");
    }
  }

  didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AutoCompleteProvider>(context, listen: false)
        .clearResultsBeforeNewSearch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadUserDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFdfbfbfb),
            body: Center(child: LoadingWidget()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Color(0xFdfbfbfb),
            appBar: AppBar(
              title: const Text('Edit Profile'),
              centerTitle: true,
            ),
            body: Center(child: Text('Error loading user data')),
          );
        } else {
          return Consumer<AuthUserProvider>(
            builder: (context, authUserProvider, child) {
              return Scaffold(
                backgroundColor: Color(0xFdfbfbfb),
                appBar: AppBar(
                  backgroundColor: Color(0xFdfbfbfb),
                  title: const Text('Edit Profile'),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: authUserProvider.userNameUpdate,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                      const SizedBox(height: 15),
                      GenderToggleButton(
                        defaultValue: authUserProvider.gender,
                        onChanged: (value) {
                          authUserProvider.gender = value;
                        },
                      ),
                      const SizedBox(height: 15),
                      CitiesBottomSheet(
                          bottomSheetTitle: 'Where do you live?',
                          defaultValue: authUserProvider.cityName),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _saveChanges(authUserProvider),
                          child: const Text('Save Changes'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
