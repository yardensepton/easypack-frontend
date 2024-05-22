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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/pages/create_user_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CreateUserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreateUserScreen(),
    );
  }
}
