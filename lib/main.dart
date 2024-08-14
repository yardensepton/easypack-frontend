import 'dart:convert';

import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/exception/server_error.dart';
import 'package:easypack/models/trip_info.dart';
import 'package:easypack/navigation_menu.dart';
import 'package:easypack/pages/intro_pages/introduction_manager.dart';
import 'package:easypack/pages/my_trips_page.dart';
import 'package:easypack/pages/signup_login/sign_up_login_screen.dart';
import 'package:easypack/pages/trip_planner_page.dart';
import 'package:easypack/providers/click_trip_provider.dart';
import 'package:easypack/providers/first_launch_provider.dart';
import 'package:easypack/providers/items_provider.dart';
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/services/user_service.dart';
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
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

Future<String?> updateTripsWeather() async {
  String? token = await UserService.getAccessToken();
  print("the token in the call back is $token");
  if (token == null) {
    print("token is null");
    return null;
  }
  final url = Uri.parse("${Urls.baseUrl}/trips/scheduled");
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final response = await http.put(url, headers: headers);
  if (response.statusCode == 200) {
    print(response.body);
    return null;
  } else if (response.statusCode == 401) {
    await UserService.refreshAccessToken();
    token = await UserService.getAccessToken();
    print("in the trip service the token is $token");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(url, headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      return null;
    } else {
      return ServerError.getErrorMsg(jsonDecode(response.body));
    }
  } else {
    return ServerError.getErrorMsg(jsonDecode(response.body));
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      print("Executing scheduled task");
      final result = await updateTripsWeather();

      if (result != null) {
        print("Error updating weather data: $result");
        return Future.value(false);
      }

      return Future.value(true);
    } catch (err) {
      print("Error in background task: $err");
      return Future.value(false);
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!kIsWeb) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerPeriodicTask(
      "task-identifier",
      "simpleTask",
      frequency: const Duration(days: 1),
    );
  }

  Hive.registerAdapter(TripInfoAdapter());
  await Hive.openBox<TripInfo>(Boxes.tripsBox);
  await Hive.openBox<bool>(Boxes.settingsBox);
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
        ChangeNotifierProvider(create: (context) => ClickTripProvider()),
        ChangeNotifierProvider(create: (context) => FirstLaunchProvider()),
        ChangeNotifierProvider(create: (context) => ItemsProvider()),
        ChangeNotifierProvider(create: (context) => PackingListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool firstLaunch = Provider.of<FirstLaunchProvider>(context, listen: false)
        .isFirstLaunch();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.redHatDisplayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: firstLaunch ? '/introduction' : '/',
      routes: {
        '/': (context) => const AuthChecker(),
        '/login': (context) => const SignUpLoginScreen(),
        '/navigation': (context) => const NavigationMenu(),
        '/tripPlanner': (context) => const TripPlannerPage(),
        '/myTrips': (context) => const MyTripsPage(),
        '/introduction': (context) => const IntroductionManager(),
      },
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
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
