import 'package:easypack/pages/create_packing_list_page.dart';
import 'package:easypack/pages/home_user.dart';
import 'package:easypack/pages/packing_list_page.dart';
import 'package:easypack/pages/trip_list_page.dart';
import 'package:easypack/pages/trip_planner_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  static  final List<Widget> _widgetOptions = <Widget>[
   CreatePackingListPage(),
 const PackingListPage(),
    const HomeUser(),
    TripsListPage(),
    const TripPlannerPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Text('Main Menu'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.globe,
                  text: 'New Trip',
                ),
                GButton(
                  icon: LineIcons.list,
                  text: 'Packing Lists',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
                             GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                  GButton(
                  icon: LineIcons.plus,
                  text: 'New Trip',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
