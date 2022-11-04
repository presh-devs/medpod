import 'package:flutter/material.dart';
import 'package:medpod/ui/refill_reminder.dart';
import 'package:medpod/ui/reminder_schedule.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:medpod/utilities/common_widgets/progress_indicator.dart';
import '../utilities/constants/colors.dart';
import '../utilities/constants/text_styles.dart';

class UsageFrequency extends StatelessWidget {
  const UsageFrequency({Key? key}) : super(key: key);

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
            progress: '3/5',
            percent: 0.6,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How often do you take this medication?',
                style: kMediumBody2TextStyle,
              ),
              SizedBox(
                height: height * 0.024,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListView.builder(
                      physics: ScrollPhysics(parent: null),
                      shrinkWrap: true,
                      itemCount: usageFrequency.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: kPrimaryTextColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RefillReminder(),
                                ),
                              );
                            },
                            child: Text(usageFrequency[index]),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> usageFrequency = [
  'Once daily',
  'Twice daily',
  'As needed',
  'Other frequency'
];
