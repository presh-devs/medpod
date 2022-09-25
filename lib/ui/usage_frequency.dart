import 'package:flutter/material.dart';

import '../utilities/constants/colors.dart';
import '../utilities/constants/text_styles.dart';

class UsageFrequency extends StatelessWidget {
  const UsageFrequency({Key? key}) : super(key: key);

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
                  'How often do you take this medication?',
                  style: kMediumBody2TextStyle.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 753,
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListView.builder(
                          physics: ScrollPhysics(parent: null),
                          shrinkWrap: true,
                          itemCount: usageFrequency.length,
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
                              child: Text(usageFrequency[index]),
                            );
                          }),
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

List<String> usageFrequency = [
  'Once daily',
  'Twice daily',
  'As needed',
  'Other frequency'
];
