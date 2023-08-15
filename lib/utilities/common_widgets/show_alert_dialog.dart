import 'package:flutter/material.dart';

 showAlertDialog(
    BuildContext context, {
      required String title,
      required String? content,
      required String defaultActionText,
      String? cancelActionText,
    }) {
   showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content!),
        actions: [
          if (cancelActionText != null)
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelActionText),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(defaultActionText),
          ),
        ],
      ),
    );
  }
