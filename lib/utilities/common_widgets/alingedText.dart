
import 'package:flutter/material.dart';

class AlignedText extends StatelessWidget {
  const AlignedText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: Text(text),);
  }
}