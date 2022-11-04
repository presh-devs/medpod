import 'package:flutter/material.dart';

import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/constants/text_styles.dart';

class ScheduleReminder extends StatelessWidget {
  const ScheduleReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          CustomProgressIndicator(
            width: width,
            progress: '4/5',
            percent: 0.8,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reminder Schedule',
              style: kMediumBody2TextStyle,
            ),
            SizedBox(
              height: height * 0.018,
            ),
            const Text(
              'Set up a reminder for your medication',
            ),
          ],
        ),
      ),
    );
  }
}
