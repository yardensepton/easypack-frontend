import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/navigation_menu.dart';
import 'package:easypack/pages/my_trips_page.dart';
import 'package:easypack/pages/signup_login/sign_up_login_screen.dart';
import 'package:easypack/pages/trip_planner_page.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:easypack/providers/create_trip_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TripInfoAdapter());
  await Hive.openBox<Map>(Boxes.tripsBox);
  await Hive.openBox<String>(Boxes.currentUserBox);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CreateUserProvider()),
        ChangeNotifierProvider(create: (context) => AutoCompleteProvider()),
        ChangeNotifierProvider(create: (context) => AuthUserProvider()),
        ChangeNotifierProvider(create: (context) => ChooseDateRangeProvider()),
        ChangeNotifierProvider(create: (context) => CreateTripProvider()),
        ChangeNotifierProvider(create: (context) => TripDetailsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<TripDetailsProvider>(context, listen: false)
        .connectToWebSocket();
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.redHatDisplayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthChecker(),
        '/login': (context) => const SignUpLoginScreen(),
        '/navigation': (context) => const NavigationMenu(),
        '/tripPlanner': (context) => const TripPlannerPage(),
        '/myTrips': (context) => const MyTripsPage(),
      },
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    print("AuthChecker build called");
    return FutureBuilder(
      future: Provider.of<AuthUserProvider>(context, listen: false)
          .getAccessToken(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        print("FutureBuilder snapshot state: ${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Waiting for access token...");
          return const Center(child: LoadingWidget());
        } else {
          if (snapshot.hasError) {
            print("Error fetching access token: ${snapshot.error}");
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final token = Provider.of<AuthUserProvider>(context, listen: false)
                .accessToken;
            print("Access token fetched: $token");
            if (token == null) {
              print("Navigating to login screen");
              return const SignUpLoginScreen();
            } else {
              print("Navigating to main navigation");
              return const NavigationMenu();
            }
          }
        }
      },
    );
  }
}
