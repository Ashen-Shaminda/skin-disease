import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double padding;
  final double margin;
  const MyButton({super.key, required this.text, required this.onTap, required this.padding, required this.margin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding:  EdgeInsets.all(padding),
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
