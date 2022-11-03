import 'package:flutter/material.dart';

import '../utilities/constants/text_styles.dart';

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
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Refill Reminder',
              style: kMediumBody2TextStyle,
            ),
            SizedBox(
              height: height * 0.018,
            ),
            const Text(
              'Get reminders to refill your meds when the minimum amount is reached.',
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ListTile(
                title: Text('Remind me'),
                leading: Radio(
                    toggleable: true,
                    value: 'Remind me',
                    groupValue: remindMe,
                    onChanged: (value) {
                      setState(() {
                        // remindMe = value.toString();
                      });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
