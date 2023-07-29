import 'package:flutter/material.dart';
import 'package:medpod/ui/refill_reminder.dart';
import 'package:medpod/ui/reminder_schedule.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utilities/common_widgets/button.dart';
import '../utilities/common_widgets/headerRow.dart';
import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/constants/colors.dart';
import '../utilities/constants/text_styles.dart';

enum MedCon { other, pnts }

class MedicalCondition extends StatefulWidget {
  final String medName;
  final String selectedDrugType;
  final String selectedUnit;
  final String quantity;
  const MedicalCondition(
      {Key? key,
      required this.medName,
      required this.selectedDrugType,
      required this.selectedUnit,
      required this.quantity})
      : super(key: key);

  @override
  State<MedicalCondition> createState() => _MedicalConditionState();
}

class _MedicalConditionState extends State<MedicalCondition> {
  MedCon _medCon = MedCon.other;

  TextEditingController conditionField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          actions: [
            CustomProgressIndicator(
              width: width,
              progress: '2/4',
              percent: 0.5,
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeaderRow1(
                  title: 'Medical Condition',
                  imageUrl: 'assets/icons/stethoscope.png'),
//: TODO add icon url
              SizedBox(
                height: height * 0.02,
              ),
              const Text(
                'What are you taking this med for?',
              ),
              SizedBox(
                height: height * 0.048,
              ),
              ListView.builder(
                  physics: const ScrollPhysics(parent: null),
                  shrinkWrap: true,
                  itemCount: medicalCondition.length,
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
                                  ScheduleReminder(
                                medName: widget.medName,
                                selectedDrugType: widget.selectedDrugType,
                                selectedUnit: widget.selectedUnit,
                                quantity: widget.quantity,
                                medCon: medicalCondition[index],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          medicalCondition[index],
                          textAlign: TextAlign.left,
                        ),
                      ),
                    );
                  }),
              TextField(
                controller: conditionField,
                onEditingComplete: ()  {
                  String condition = conditionField.text;
                  medicalCondition.add(conditionField.text);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ScheduleReminder(
                        medName: widget.medName,
                        selectedDrugType: widget.selectedDrugType,
                        selectedUnit: widget.selectedUnit,
                        quantity: widget.quantity,
                        medCon: condition,
                      ),
                    ),
                  );
                  //conditionField.clear();
                },
                decoration: const InputDecoration(
                  enabled: true,
                  labelText: 'Others(please specify)',
                ),
              ),
              ListTile(
                title: const Text('other'),
                leading: Radio(
                    value: MedCon.other,
                    groupValue: _medCon,
                    onChanged: (MedCon? value) {
                      setState(() {
                        _medCon = value!;
                      });
                    }),
              ),
              ListTile(
                title: const Text('Prefer not to say'),
                leading: Radio(
                    value: MedCon.pnts,
                    groupValue: _medCon,
                    onChanged: (MedCon? value) {
                      setState(() {
                        _medCon = value!;
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> medicalCondition = <String>[
  'Arthritis',
  'Asthma',
  'Cancer',
  'Cardiovascular (Heart) disease',
  'Diabetes',
  'Hypertension',
  'Mental Health',
  'Sickle Cell anemia'
];
