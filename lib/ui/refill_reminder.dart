import 'package:flutter/material.dart';
import 'package:medpod/models/med.dart';
import 'package:medpod/models/medication.dart';
import 'package:medpod/services/database.dart';
import 'package:medpod/ui/bottom_navBar/bottomNavBar.dart';
import 'package:medpod/ui/reminder_schedule.dart';
import 'package:provider/provider.dart';
import '../models/boxes.dart';
import '../services/auth.dart';
import '../services/firestore_service.dart';
import '../utilities/common_widgets/button.dart';
import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/common_widgets/headerRow.dart';

class RefillReminder extends StatefulWidget {
  const RefillReminder({
    Key? key,
    required this.medName,
    required this.selectedDrugType,
    required this.selectedUnit,
    required this.quantity,
    required this.medCon,
    required this.time,
    required this.startDate,
    required this.endDate,
    required this.frequency,
    //required this.database,
  }) : super(key: key);
  //final Database database;
  final String medName;
  final String selectedDrugType;
  final String selectedUnit;
  final String quantity;
  final String medCon;
  final String time;
  final String startDate;
  final String endDate;
  final String frequency;

  @override
  State<RefillReminder> createState() => _RefillReminderState();
}

class _RefillReminderState extends State<RefillReminder> {
  final _service = FirestoreService.instance;
  Future? addmed(
      String name,
      String medType,
      String unit,
      String quantity,
      String medicalCondition,
      String frequency,
      String time,
      String startDate,
      String endDate,
      String currentSupply,
      String minimumSupply) {
    final meds = Med()
      ..name = name
      ..medType = medType
      ..unit = unit
      ..quantity = quantity
      ..medicalCondition = medicalCondition
      ..frequency = frequency
      ..time = time
      ..endDate = endDate
      ..startDate = startDate
      ..currentSupply = currentSupply
      ..minimumSupply = minimumSupply;

    final box = Boxes.getMeds();
    box.add(meds);
  }

  void submit() {}

  String? remindMe;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.currentUser;
    //final database = Provider.of<Database>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Medication medication = Medication()
      ..name = widget.medName
      ..medType = widget.selectedDrugType
      ..unit = widget.selectedUnit
      ..quantity = widget.quantity
      ..medicalCondition = widget.medCon
      ..frequency = widget.frequency
      ..time = widget.time
      ..endDate = widget.endDate
      ..startDate = widget.startDate
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
                    Text('Remind me'),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  children: [
                    Text('Current Suppy'),
                    SizedBox(
                      width: width * 0.3,
                    ),
                    Text('Minimum Suppy'),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    smallContainer(
                      iconUrl: 'assets/icons/clock.svg',
                      text: '-pills',
                      onTap: () {},
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
                  height: height * 0.05,
                ),
                CustomButton(
                  title: 'Next',
                  isButtonDisabled: false,
                  onPressed: () {
                    // _service.setData(
                    //     path: 'users/${auth.currentUser!.uid}/meds',
                    //     data: medication.toMap());
                    //:Todo update min and current supply
                    addmed(
                        widget.medName,
                        widget.selectedDrugType,
                        widget.selectedUnit,
                        widget.quantity,
                        widget.medCon,
                        widget.frequency,
                        widget.time,
                        widget.startDate,
                        widget.endDate,
                        'currentSupply',
                        'minimumSupply');
                    database.setMed(medication);
database.printMed();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: false,
                        builder: (context) => const BottomNavBar(),
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
