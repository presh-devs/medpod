import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medpod/views/refill_reminder.dart';
import '../utilities/common_widgets/alinged_text.dart';
import '../utilities/common_widgets/button.dart';
import '../utilities/common_widgets/dropdown_button.dart';
import '../utilities/common_widgets/header_row.dart';
import '../utilities/common_widgets/progress_indicator.dart';

class ScheduleReminder extends StatefulWidget {
  final String medName;
  final String selectedDrugType;
  final String selectedUnit;
  final String quantity;
  final String medCon;
  const ScheduleReminder(
      {super.key,
      required this.medName,
      required this.selectedDrugType,
      required this.selectedUnit,
      required this.quantity,
      required this.medCon});

  @override
  State<ScheduleReminder> createState() => _ScheduleReminderState();
}

class _ScheduleReminderState extends State<ScheduleReminder> {
  TimeOfDay _time = TimeOfDay.now();
  String? startDate;
  String? endDate ;



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

  final _months = {
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
        startDate = month!;
      }
    }
    return startDate;
  }

  String? getEndMonth(String date) {
    for (var key in _months.keys) {
      if (date == key) {
        var month = _months[date];
        endDate = month!;
      }
    }
    return endDate;
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
      });
    });
  }

  //getEndMonth(dateRange.end.month.toString())!;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //final difference = dateRange.duration;
    String formattedStartDate = '${getEndMonth(dateRange.start.month.toString())!},${dateRange.start.day}';
    String formattedEndDate = '${getEndMonth(dateRange.end.month.toString())!},${dateRange.end.day}';

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
                  SmallContainer(
                    iconUrl: 'assets/icons/unfilledCalendar.svg',
                    text: formattedStartDate,
                    //'$startDate,${_startDateTime.day.toString()}',
                    onTap: pickDateRange,
                    //_showStartDatePicker,
                  ),
                  SizedBox(width: width * 0.07),
                  SmallContainer(
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
                  SmallContainer(
                    iconUrl: 'assets/icons/clock.svg',
                    text: _time.format(context).toString(),
                    onTap: _showTimePicker,
                  ),
                  SizedBox(width: width * 0.07),
                  SmallContainer(
                    iconUrl: 'assets/icons/bluePill.svg',
                    text: '2 ${widget.selectedDrugType}',
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
                onPressed: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) => RefillReminder(
                        medName: widget.medName,
                        selectedDrugType: widget.selectedDrugType,
                        selectedUnit: widget.selectedUnit,
                        quantity: widget.quantity,
                        medCon: widget.medCon,
                        time: _time,
                        dateTimeRange:dateRange,
                        fEndDate: formattedEndDate,
                        fStartDate: formattedStartDate,
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

class SmallContainer extends StatelessWidget {
  final String iconUrl;
  final String text;
  final VoidCallback onTap;
  const SmallContainer({
    super.key,
    required this.iconUrl,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
