import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/presentation/screens/person_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: const PersonScreen(),
    );
  }
}
