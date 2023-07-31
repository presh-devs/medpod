import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medpod/services/database.dart';
import 'package:medpod/services/notification_service.dart';
import 'package:medpod/ui/refill_reminder.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../utilities/common_widgets/alingedText.dart';
import '../utilities/common_widgets/button.dart';
import '../utilities/common_widgets/dropdownButton.dart';
import '../utilities/common_widgets/headerRow.dart';
import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/constants/text_styles.dart';

class ScheduleReminder extends StatefulWidget {
  final String medName;
  final String selectedDrugType;
  final String selectedUnit;
  final String quantity;
  final String medCon;
  const ScheduleReminder(
      {Key? key,
      required this.medName,
      required this.selectedDrugType,
      required this.selectedUnit,
      required this.quantity,
      required this.medCon})
      : super(key: key);

  @override
  State<ScheduleReminder> createState() => _ScheduleReminderState();
}

class _ScheduleReminderState extends State<ScheduleReminder> {
  TimeOfDay _time = const TimeOfDay(hour: 4, minute: 00);
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now();
  var startMonth = 'Jan';
  var endMonth = 'Jan';

  NotificationService notificationService = NotificationService();

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _time = value!;
      });
    });
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

  String? getStartMonth(String date) {
    for (var key in _months.keys) {
      if (date == key) {
        var month = _months[date];
        startMonth = month!;
        print(startMonth);
      }
    }
    return startMonth;
  }

  String? getEndMonth(String date) {
    for (var key in _months.keys) {
      if (date == key) {
        var month = _months[date];
        endMonth = month!;
        print(endMonth);
      }
    }
    return endMonth;
  }

  void pickDateRange() {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(1000),
      lastDate: DateTime(2100),
      initialDateRange: dateRange,
    ).then((value) {
      if (value == null) return;
      setState(() {
        dateRange = value;
        startMonth = getStartMonth(dateRange.start.month.toString())!;
        endMonth = getEndMonth(dateRange.end.month.toString())!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final start = dateRange.start;
    final end = dateRange.end;

    final tZone = tz.local;

    tz.TZDateTime tzDateTimeStart = tz.TZDateTime.from(dateRange.start, tZone);
    tz.TZDateTime tzDateTimeEnd = tz.TZDateTime.from(dateRange.end, tZone);

    final difference = dateRange.duration;
    String formattedStartDate = '$startMonth,${start.day}';
    String formattedEndDate = '$endMonth,${end.day}';

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
      body: SingleChildScrollView(
        child: Padding(
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
                  const Text('Start Date'),
                  SizedBox(
                    width: width * 0.357,
                  ),
                  const Text('End Date'),
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
                    text: formattedStartDate,
                    //'$startDate,${_startDateTime.day.toString()}',
                    onTap: pickDateRange,
                    //_showStartDatePicker,
                  ),
                  SizedBox(width: width * 0.07),
                  smallContainer(
                    iconUrl: 'assets/icons/unfilledCalendar.svg',
                    text: formattedEndDate,
                    onTap: pickDateRange,
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
                  const Text('Time'),
                  SizedBox(
                    width: width * 0.425,
                  ),
                  const Text('Dosage'),
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
                onPressed: () async {
                  await notificationService.scheduleNotifications(
                      id: 1,
                      title: 'Med Reminder',
                      body: 'Time to use your ${widget.medName} ${widget.selectedDrugType}',
                      time: DateTime(start.year, start.month, start.day,
                          _time.hour, _time.minute));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) => RefillReminder(
                        // database: Database(),
                        medName: widget.medName,
                        selectedDrugType: widget.selectedDrugType,
                        selectedUnit: widget.selectedUnit,
                        quantity: widget.quantity,
                        medCon: widget.medCon,
                        time: _time.format(context).toString(),
                        //DateTime.fromMicrosecondsSinceEpoch(DateTime.parse(_time.format(context)).millisecondsSinceEpoch),
                        //DateTime.fromTimeOfDay(_time).millisecondsSinceEpoch,
                        // _time.format(context).toString(),
                        startDate: formattedStartDate,
                        endDate: formattedEndDate,
                        frequency: selectedFrequency,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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

//if (newDateRange == null ) return;

// void _showStartDatePicker() {
//   showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2030),
//   ).then((value) {
//     setState(() {
//       _startDateTime = value!;
//       getStartMonth(_startDateTime.month.toString());
//     });
//   });
// }

// void _showEndDatePicker() {
//   showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2030),
//   ).then((value) {
//     setState(() {
//       _endDateTime = value!;
//       getEndMonth(_endDateTime.month.toString());
//     });
//   });
// }

//
// String? getEndMonth(String date) {
//   for (var key in _months.keys) {
//     if (date == key) {
//       var month = _months[date];
//       endMonth = month!;
//     }
//   }
//   return endMonth;
// }
