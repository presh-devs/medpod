import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medpod/ui/refill_reminder.dart';

import '../utilities/common_widgets/alingedText.dart';
import '../utilities/common_widgets/button.dart';
import '../utilities/common_widgets/dropdownButton.dart';
import '../utilities/common_widgets/headerRow.dart';
import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/constants/text_styles.dart';

class ScheduleReminder extends StatefulWidget {
  const ScheduleReminder({Key? key}) : super(key: key);

  @override
  State<ScheduleReminder> createState() => _ScheduleReminderState();
}

class _ScheduleReminderState extends State<ScheduleReminder> {
  TimeOfDay _time = const TimeOfDay(hour: 4, minute: 00);
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now();
  var startDate;
  var endDate;

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _time = value!;
      });
    });
  }

  void _showStartDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _startDateTime = value!;
      });
    });

    getStartMonth(_startDateTime.month.toString());

  }

  void _showEndDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _endDateTime = value!;
      });
    });
    getEndMonth(_endDateTime.month.toString());
  }

  var _months = {
    '1': 'Jan',
    '2': 'Feb',
    '3': 'Mar',
    '4': 'Apr',
    '5': 'May',
    '6': 'Jun',
    '7': 'Jul',
    '8': 'Aug',
    '9': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec',
  };

  String? getStartMonth(String date ){
for (var key in _months.keys){
  if (date == key){
    var month = _months[date];
    startDate = month;
    print(startDate) ;
  }

} return startDate;
  }
  String? getEndMonth(String date ){
    for (var key in _months.keys){
      if (date == key){
        var month = _months[date];
        endDate = month;
        print(endDate) ;
      }

    } return endDate;
  }

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
            progress: '3/4',
            percent: 0.75,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            buildHeaderRow1(
                title: 'Reminder Schedule',
                imageUrl: 'assets/icons/calendar.png'),
            SizedBox(
              height: height * 0.018,
            ),
            const Text(
              'Set up a reminder for your medication',
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              children: [
                Text('Start Date'),
                SizedBox(
                  width: width * 0.357,
                ),
                Text('End Date'),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Row(
              children: [
                smallContainer(
                  iconUrl: 'assets/icons/unfilledCalendar.svg',
                  text:
                      '$startDate,${_startDateTime.day.toString()}',
                  onTap: _showStartDatePicker,
                ),
                SizedBox(width: width * 0.07),
                smallContainer(
                  iconUrl: 'assets/icons/unfilledCalendar.svg',
                  text:
                      '$endDate,${_endDateTime.day.toString()}',
                  onTap: _showEndDatePicker,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            const AlignedText(text: 'Frequency'),
            SizedBox(
              height: height * 0.01,
            ),
            buildFrequencyDropdown(),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              children: [
                Text('Time'),
                SizedBox(
                  width: width * 0.425,
                ),
                Text('Dosage'),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Row(
              children: [
                smallContainer(
                  iconUrl: 'assets/icons/clock.svg',
                  text: _time.format(context).toString(),
                  onTap: _showTimePicker,
                ),
                SizedBox(width: width * 0.07),
                smallContainer(
                  iconUrl: 'assets/icons/bluePill.svg',
                  text: '2 pills',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            CustomButton(
              title: 'Next',
              isButtonDisabled: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: false,
                    builder: (context) => const RefillReminder(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<String> usageFrequency = [
    'Once daily',
    'Twice daily',
    'As needed',
    'Other frequency'
  ];

  String selectedFrequency = 'Once daily';

  Widget buildFrequencyDropdown() {
    return CustomDropdownButton(
      items: usageFrequency,
      onChanged: (String? newValue) {
        setState(() {
          selectedFrequency = newValue!;
        });
      },
      dropdownValue: selectedFrequency,
      isExpanded: true,
      title: 'Usage Frequency',
      hintText: 'Select Frequency',
    );
  }
}

class smallContainer extends StatelessWidget {
  final String iconUrl;
  final String text;
  final VoidCallback onTap;
  const smallContainer({
    Key? key,
    required this.iconUrl,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65,
        width: width * 0.42,
        decoration: BoxDecoration(
          // color: Colors.grey,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onTap,
              icon: SvgPicture.asset(iconUrl),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
