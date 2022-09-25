import 'package:flutter/material.dart';
import 'package:medpod/ui/usage_frequency.dart';

import '../utilities/common_widgets/button.dart';
import '../utilities/constants/colors.dart';
import '../utilities/constants/text_styles.dart';

class MedicalCondition extends StatelessWidget {
  const MedicalCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  width: 75,
                ),
                Text(
                  'Hydroxyurea 500mg',
                  style: kMediumBody2TextStyle.copyWith(color: Colors.white),
                ),
              ]),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'What are you taking his med for?',
                  style: kMediumBody2TextStyle.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 830,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListView.builder(
                          physics: ScrollPhysics(parent: null),
                          shrinkWrap: true,
                          itemCount: medicalCondition.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
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
                            );
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          enabled: true,
// hintText: '@gmail.com',
                          labelText: 'Other(please specify)',
                        ),
                      ),
                    ],
                  ),
                ),
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
