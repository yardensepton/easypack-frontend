import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text('Settings',style: TextStyle(color: Colors.white),),
            ),
            ListTile(
              leading: const Icon(LineIcons.userEdit),
              title: const Text('Edit your profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Log out'),
              onTap: () {
                logOutButton(context);
              },
              
            ),
                        ListTile(
              leading: const Icon(LineIcons.removeUser,color: Color.fromARGB(255, 150, 50, 43),),
              title: const Text('Delete your account',style: TextStyle(color: Color.fromARGB(255, 150, 50, 43)),),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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