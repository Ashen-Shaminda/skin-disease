import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

class UserFeedback extends StatelessWidget {
  const UserFeedback({super.key});

  feedback(BuildContext context) {
    BetterFeedback.of(context).show((feedback) => null);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: feedback(context),
      icon: const Icon(Icons.bug_report),
    );
  }
}
