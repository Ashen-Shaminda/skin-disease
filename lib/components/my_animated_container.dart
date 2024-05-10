import 'package:flutter/material.dart';

class MyAnimatedContainer extends StatelessWidget {
  final Widget child;

  const MyAnimatedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 4),
              blurStyle: BlurStyle.solid),
        ],
      ),
      child: child,
    );
  }
}
