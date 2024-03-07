
import 'package:flutter/material.dart';

class AlignedText extends StatelessWidget {
  const AlignedText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: Text(text),);
  }
}