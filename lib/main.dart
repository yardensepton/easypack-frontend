import 'package:flutter/material.dart';
import 'package:easypack/pages/create_user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pages',
      initialRoute: '/',
      routes: {
        '/': (context) => const CreateUserScreen(),
        // '/second': (context) => const ChooseDates(),
      },
    );
  }
}
