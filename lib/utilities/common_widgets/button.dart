import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.isButtonDisabled = true})
      : super(key: key);
  final String title;
  final VoidCallback? onPressed;
  final bool isButtonDisabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: SizedBox(
        height: 58,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isButtonDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 2,
            primary: kDefaultButtonColor,
            onSurface: kDefaultButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Text(
            title,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
