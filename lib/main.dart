// import 'package:easypack/navigation_menu.dart';
// import 'package:easypack/pages/signup_login/sign_up_login_screen.dart';
// import 'package:easypack/pages/trip_planner_page.dart';
// import 'package:easypack/providers/trip_details_provider.dart';
// import 'package:easypack/socket_channel.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:easypack/providers/auto_complete_provider.dart';
// import 'package:easypack/providers/auth_user_provider.dart';
// import 'package:easypack/providers/choose_date_range_provider.dart';
// import 'package:easypack/providers/create_trip_provider.dart';
// import 'package:easypack/providers/create_user_provider.dart';
// // import 'package:web_socket_channel/status.dart' as status;

// void main() {

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => CreateUserProvider()),
//         ChangeNotifierProvider(create: (context) => AutoCompleteProvider()),
//         ChangeNotifierProvider(create: (context) => AuthUserProvider()),
//         ChangeNotifierProvider(create: (context) => ChooseDateRangeProvider()),
//         ChangeNotifierProvider(create: (context) => CreateTripProvider()),
//         ChangeNotifierProvider(create: (context) => TripDetailsProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<TripDetailsProvider>(context, listen: false).connectToWebSocket();

//     return MaterialApp(
//       theme: ThemeData(
//         textTheme: GoogleFonts.redHatDisplayTextTheme(
//           Theme.of(context).textTheme,
//         ),
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const AuthChecker(),
//         '/login': (context) => const SignUpLoginScreen(),
//         '/navigation': (context) => const NavigationMenu(),
//         '/tripPlanner': (context) => const TripPlannerPage(),
//       },
//     );
//   }
// }

// // AuthChecker widget checks if user is authenticated and navigates accordingly
// class AuthChecker extends StatelessWidget {
//   const AuthChecker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Provider.of<AuthUserProvider>(context, listen: false)
//           .getAccessToken(context),
//       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final token = snapshot.data;
//             if (token == null) {
//               return const SignUpLoginScreen(); // Navigate to login screen if token is null
//             } else {
//               return const NavigationMenu(); // Navigate to main navigation if token is present
//             }
//           }
//         }
//       },
//     );
//   }
// }
import 'package:easypack/navigation_menu.dart';
import 'package:easypack/pages/signup_login/sign_up_login_screen.dart';
import 'package:easypack/pages/trip_planner_page.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:easypack/providers/create_trip_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
// import 'package:web_socket_channel/status.dart' as status;

void main() {
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
     Provider.of<TripDetailsProvider>(context, listen: false).connectToWebSocket();
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
      },
    );
  }
}

// class AuthChecker extends StatelessWidget {
//   const AuthChecker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Provider.of<AuthUserProvider>(context, listen: false).getAccessToken(),
//       builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final token = Provider.of<AuthUserProvider>(context, listen: false).accessToken;
//             if (token == null) {
//               return const SignUpLoginScreen(); // Navigate to login screen if token is null
//             } else {
//               return const NavigationMenu(); // Navigate to main navigation if token is present
//             }
//           }
//         }
//       },
//     );
//   }
// }
class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    print("AuthChecker build called");
    return FutureBuilder(
      future: Provider.of<AuthUserProvider>(context, listen: false).getAccessToken(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        print("FutureBuilder snapshot state: ${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Waiting for access token...");
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            print("Error fetching access token: ${snapshot.error}");
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final token = Provider.of<AuthUserProvider>(context, listen: false).accessToken;
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