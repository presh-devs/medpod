import 'package:flutter/material.dart';

import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/constants/text_styles.dart';
import '../utilities/common_widgets/headerRow.dart';
class RefillReminder extends StatefulWidget {
  const RefillReminder({Key? key}) : super(key: key);

  @override
  State<RefillReminder> createState() => _RefillReminderState();
}

class _RefillReminderState extends State<RefillReminder> {
  String? remindMe;
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
            progress: '4/4',
            percent: 1.0,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderRow1(title: 'Reminder Schedule', imageUrl: 'assets/icons/clock.png'),
//: TODO add icon url
            SizedBox(
              height: height * 0.018,
            ),
            const Text(
              'Get reminders to refill your meds when the minimum amount is reached.',
            ),
            Row(
              children: [
                Radio(
                    toggleable: true,
                    value: 'Remind me',
                    groupValue: remindMe,
                    onChanged: (value) {
                      setState(() {
                        // remindMe = value.toString();
                      });
                    }),
                Text('Remind me'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
