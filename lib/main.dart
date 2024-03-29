import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skin_diseases_detection_system/home.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
