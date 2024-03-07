import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isButtonDisabled = true});
  final String title;
  final VoidCallback? onPressed;
  final bool isButtonDisabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 58,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isButtonDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: kDefaultButtonColor,
            disabledForegroundColor: kDefaultButtonColor.withOpacity(0.38),
            disabledBackgroundColor: const Color(0xffC7C6CA),
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
//background: #0xffC7C6CA;
//kDefaultButtonColor.withOpacity(0.12)
