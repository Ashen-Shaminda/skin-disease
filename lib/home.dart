import 'package:flutter/material.dart';

import 'package:skin_diseases_detection_system/pages/model_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ModelPage(),
    );
  }
}
