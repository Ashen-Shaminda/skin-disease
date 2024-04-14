import 'package:flutter/material.dart';
import 'package:skin_diseases_detection_system/components/feedback.dart';

class PopMenu extends StatelessWidget {
  const PopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book),
        itemBuilder: (context) {
      return [
        const PopupMenuItem<int>(
          value: 0,
          child: UserFeedback(),
        ),
      ];
      // TODO : Remove onSelected property
    }, onSelected: (value) {
      if (value == 0) {
        print("Bug Report");
      } else if (value == 1) {
        print("Settings menu is selected.");
      } else if (value == 2) {
        print("Logout menu is selected.");
      }
    });
  }
}
