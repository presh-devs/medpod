import 'package:flutter/material.dart';
import 'package:medpod/views/reminder_schedule.dart';
import 'package:medpod/utilities/constants/button_style.dart';
import '../utilities/common_widgets/header_row.dart';
import '../utilities/common_widgets/progress_indicator.dart';

enum MedCon { supplements, pnts }

class MedicalCondition extends StatefulWidget {
  final String medName;
  final String selectedDrugType;
  final String selectedUnit;
  final String quantity;
  const MedicalCondition(
      {super.key,
      required this.medName,
      required this.selectedDrugType,
      required this.selectedUnit,
      required this.quantity});

  @override
  State<MedicalCondition> createState() => _MedicalConditionState();
}

class _MedicalConditionState extends State<MedicalCondition> {
  MedCon? _medCon;

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
              SizedBox(
                height: height * 0.017,
              ),
              const Text(
                'What are you taking this med for?',
              ),
              SizedBox(
                height: height * 0.04,
              ),
              ListView.builder(
                  physics: const ScrollPhysics(parent: null),
                  shrinkWrap: true,
                  itemCount: medicalCondition.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: kTextButtonStyle,
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
                onEditingComplete: () {
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
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ScheduleReminder(
                          medName: widget.medName,
                          selectedDrugType: widget.selectedDrugType,
                          selectedUnit: widget.selectedUnit,
                          quantity: widget.quantity,
                          medCon: 'Supplements',
                        ),
                      ),
                    ),
                    child: const Text('Supplements'),
                  ),
                ),
                leading: Radio(
                    value: MedCon.supplements,
                    groupValue: _medCon,
                    onChanged: (MedCon? value) {
                      setState(() {
                        _medCon = value!;
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => ScheduleReminder(
                            medName: widget.medName,
                            selectedDrugType: widget.selectedDrugType,
                            selectedUnit: widget.selectedUnit,
                            quantity: widget.quantity,
                            medCon: 'Supplements',
                          ),
                        ),
                      );
                    }),
              ),
              ListTile(
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(style: kTextButtonStyle,
                      onPressed: () =>Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ScheduleReminder(
                        medName: widget.medName,
                        selectedDrugType: widget.selectedDrugType,
                        selectedUnit: widget.selectedUnit,
                        quantity: widget.quantity,
                        medCon: 'Supplements',
                      ),
                    ),
                  ),
                  child: const Text('Prefer not to say')),
                ),
                leading: Radio(
                    value: MedCon.pnts,
                    groupValue: _medCon,
                    onChanged: (MedCon? value) {
                      setState(() {
                        _medCon = value!;
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => ScheduleReminder(
                            medName: widget.medName,
                            selectedDrugType: widget.selectedDrugType,
                            selectedUnit: widget.selectedUnit,
                            quantity: widget.quantity,
                            medCon: 'Prefer not to say',
                          ),
                        ),
                      );
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
