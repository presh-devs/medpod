import 'package:flutter/material.dart';
import 'package:medpod/models/medication.dart';
import 'package:medpod/services/database.dart';
import 'package:medpod/views/bottom_navBar/bottom_navbar.dart';
import 'package:medpod/views/reminder_schedule.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../services/notification_service.dart';
import '../utilities/common_widgets/button.dart';
import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/common_widgets/header_row.dart';

class RefillReminder extends StatefulWidget {
  const RefillReminder({
    super.key,
    required this.medName,
    required this.selectedDrugType,
    required this.selectedUnit,
    required this.quantity,
    required this.medCon,
    required this.time,
    // required this.startDate,
    // required this.endDate,
    required this.frequency, required this.fStartDate, required this.fEndDate, required this.dateTimeRange,
    //required this.database,
  });
  //final Database database;
  final String medName;
  final String selectedDrugType;
  final String selectedUnit;
  final String quantity;
  final String medCon;
  final TimeOfDay time;
  final String fStartDate;
  final String fEndDate;
  // final DateTimeRange startDate;
  // final DateTimeRange endDate;
  final DateTimeRange dateTimeRange;
  final String frequency;

  @override
  State<RefillReminder> createState() => _RefillReminderState();
}

class _RefillReminderState extends State<RefillReminder> {
  // final _service = FirestoreService.instance;
  NotificationService notificationService = NotificationService();

  String? remindMe;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.currentUser;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Medication medication = Medication()
      ..name = widget.medName
      ..medType = widget.selectedDrugType
      ..unit = widget.selectedUnit
      ..quantity = widget.quantity
      ..medicalCondition = widget.medCon
      ..frequency = widget.frequency
      ..time = widget.time.format(context).toString()
      ..endDate = widget.fEndDate
      ..startDate = widget.fStartDate
      ..currentSupply = 'widget.'
      ..minimumSupply = 'widget.minimumSupply';

    return Provider<Database>(
      create: (context) => FirestoreDatabase(uid: auth.currentUser!.uid),
      builder: (context, child) {
        final database = Provider.of<Database>(context, listen: false);
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
                buildHeaderRow1(
                    title: 'Refill Reminder',
                    imageUrl: 'assets/icons/clock.png'),
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
                            remindMe = value.toString();
                          });
                        }),
                    const Text('Remind me'),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  children: [
                    const Text('Current Suppy'),
                    SizedBox(
                      width: width * 0.3,
                    ),
                    const Text('Minimum Suppy'),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    SmallContainer(
                      iconUrl: 'assets/icons/clock.svg',
                      text: '-pills',
                      onTap: () {},
                    ),
                    SizedBox(width: width * 0.07),
                    SmallContainer(
                      iconUrl: 'assets/icons/bluePill.svg',
                      text: '2 pills',
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomButton(
                  title: 'Next',
                  isButtonDisabled: false,
                  onPressed: () async {
                    //:Todo update min and current supply
                    database.setMed(medication);
                    // database.printMed();
                    await notificationService.scheduleNotifications(
                        id: 1,
                        title: 'Med Reminder',
                        body: 'Time to use your ${widget.medName} ${widget.selectedDrugType}',
                        time: DateTime(widget.dateTimeRange.start.year, widget.dateTimeRange.start.month, widget.dateTimeRange.start.day,
                            widget.time.hour, widget.time.minute));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: false,
                        builder: (context) =>  BottomNavBar(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
