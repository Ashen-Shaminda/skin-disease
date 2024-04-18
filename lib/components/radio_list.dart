import 'package:flutter/material.dart';

class RadioList extends StatelessWidget {
  final String value;
  final String text;
  final String? groupValue;

  const RadioList({
    super.key,
    required this.value,
    required this.groupValue,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: RadioListTile(
        title: Text(text),
        value: value,
        groupValue: groupValue,
        onChanged: (String? value) {},
      ),
    );
  }
}
