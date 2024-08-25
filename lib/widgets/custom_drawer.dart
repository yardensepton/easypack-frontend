import 'package:easypack/pages/edit_profile_page.dart';
import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/slide_page_route.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
            ),
            child: Text('Settings', style: TextStyle(color: Colors.black)),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(LineIcons.userEdit),
                  title: const Text('Edit your profile'),
                  onTap: () {
                    Navigator.pop(context);
                    _openEditProfilePage(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Log out'),
                  onTap: () {
                    logOutButton(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void logOutButton(BuildContext context) {
  Provider.of<TripDetailsProvider>(context, listen: false).reset();
  Provider.of<AuthUserProvider>(context, listen: false).logOutUser(context);
  Provider.of<CreateUserProvider>(context, listen: false)
      .moveToLoginScreen(context);
}
  void _openEditProfilePage(BuildContext context) {
    Navigator.of(context).push(_createRoute());
  }


  Route _createRoute() {
  return SlidePageRoute(
    page: EditProfilePage(),
  );
}
