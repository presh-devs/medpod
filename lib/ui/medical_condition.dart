import 'package:flutter/material.dart';
import 'package:medpod/ui/usage_frequency.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utilities/common_widgets/button.dart';
import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/constants/colors.dart';
import '../utilities/constants/text_styles.dart';

enum MedCon { other, pnts }

class MedicalCondition extends StatefulWidget {
  const MedicalCondition({Key? key}) : super(key: key);

  @override
  State<MedicalCondition> createState() => _MedicalConditionState();
}

class _MedicalConditionState extends State<MedicalCondition> {
  MedCon _medCon = MedCon.other;
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
              progress: '2/5',
              percent: 0.4,
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Medical Condition',
                style: kBodyLTextStyle1,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'What are you taking his med for?',
              ),
              SizedBox(
                height: height * 0.048,
              ),
              ListView.builder(
                  physics: ScrollPhysics(parent: null),
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
                                  UsageFrequency(),
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
              const TextField(
                decoration: InputDecoration(
                  enabled: true,
// hintText: '@gmail.com',
                  labelText: 'Other(please specify)',
                ),
              ),
              ListTile(
                title: Text('other'),
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
                title: Text('Prefer not to say'),
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
