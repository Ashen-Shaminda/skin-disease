import 'package:flutter/material.dart';

import 'package:skin_diseases_detection_system/pages/model_page.dart';
import 'components/my_drawer.dart';
import 'components/popup_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Skin Disease Detection",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          actions: const [PopMenu()],
        ),
        body: const SingleChildScrollView(
          child: ModelPage(),
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}
