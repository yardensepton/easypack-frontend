import 'package:easypack/pages/create_packing_list_page.dart';
import 'package:easypack/pages/home_user.dart';
import 'package:easypack/pages/packing_list_page.dart';
import 'package:easypack/pages/trip_details_page.dart';
import 'package:easypack/pages/trip_list_page.dart';
import 'package:easypack/pages/trip_planner_page.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:easypack/providers/create_trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  void _clearData(int index) {
    switch (index) {
      case 4:
        Provider.of<AutoCompleteProvider>(context, listen: false)
            .clearResultsBeforeNewSearch();
        Provider.of<ChooseDateRangeProvider>(context, listen: false)
            .clearControllers();
        break;
    }
  }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    CreatePackingListPage(),
    const PackingListPage(),
    const HomeUser(),
    const TripDetailsPage(),
    const TripPlannerPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  icon: LineIcons.clock,
                  text: 'Upcoming Trip',
                ),
                GButton(
                  icon: LineIcons.plus,
                  text: 'New Trip',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                _clearData(index);
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
