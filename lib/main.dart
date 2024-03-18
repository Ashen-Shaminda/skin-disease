import 'package:flutter/material.dart';
import 'package:skin_diseases_detection_system/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromARGB(209, 4, 97, 34)),
      ),
      home: const Home(),
    );
  }
}
