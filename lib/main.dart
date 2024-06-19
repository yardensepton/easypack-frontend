// import 'package:easypack/navigation_menu.dart';
// import 'package:easypack/pages/trip_planner_page.dart';
// import 'package:flutter/material.dart';
// // import 'package:easypack/pages/create_user_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pages',
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const NavigationMenu(),
//         // '/second': (context) => const ChooseDates(),
//       },
//     );
//   }
// }
// import 'package:easypack/pages/signup_login/sign_up_login_screen.dart';
// import 'package:easypack/pages/trip_planner_page.dart';

// import 'package:easypack/providers/auto_complete_provider.dart';
// import 'package:easypack/providers/auth_user_provider.dart';
// import 'package:easypack/providers/choose_date_range_provider.dart';
// import 'package:easypack/providers/create_trip_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:easypack/providers/create_user_provider.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => CreateUserProvider()),
//         ChangeNotifierProvider(create: (context) => AutoCompleteProvider()),
//         ChangeNotifierProvider(create: (context) => AuthUserProvider()),
//         ChangeNotifierProvider(create: (context) => ChooseDateRangeProvider()),
//         ChangeNotifierProvider(create: (context) => CreateTripProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: SignUpLoginScreen(),
//     );
//   }
// }
import 'package:easypack/navigation_menu.dart';
import 'package:easypack/pages/signup_login/sign_up_login_screen.dart';
import 'package:easypack/pages/trip_planner_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:easypack/providers/create_trip_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CreateUserProvider()),
        ChangeNotifierProvider(create: (context) => AutoCompleteProvider()),
        ChangeNotifierProvider(create: (context) => AuthUserProvider()),
        ChangeNotifierProvider(create: (context) => ChooseDateRangeProvider()),
        ChangeNotifierProvider(create: (context) => CreateTripProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        textTheme: GoogleFonts.redHatDisplayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: Provider.of<AuthUserProvider>(context, listen: false)
              .getAccessToken(context),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final token = snapshot.data;
                print(token);
                if (token == null) {
                  return const SignUpLoginScreen();
                } else {
                  return const NavigationMenu();
                }
              }
            }
          },
        ),
      ),
    );
  }
}

