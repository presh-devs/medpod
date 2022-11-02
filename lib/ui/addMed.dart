import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medpod/ui/medical_condition.dart';
import 'package:medpod/utilities/common_widgets/button.dart';
import 'package:medpod/utilities/constants/colors.dart';
import 'package:medpod/utilities/constants/text_styles.dart';

import '../utilities/common_widgets/dropdownButton.dart';
import 'bottom_navBar/medication.dart';

class AddMed extends StatefulWidget {
  const AddMed({Key? key}) : super(key: key);

  @override
  State<AddMed> createState() => _AddMedState();
}

class _AddMedState extends State<AddMed> {
  String selectedDrugType = 'Pills';
  List<String> drugType = <String>[
    'Pills',
    'Solution',
    'Injection',
    'Powder',
    'Drops',
    'Inhaler',
    'Others'
  ];
  String selectedUnit = 'mg';
  List<String> units = <String>[
    'g',
    'IU',
    'mg',
    'ml',
    'mEq',
    '%',
    'unit',
  ];
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
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
                  'Add Medication',
                  style: kMediumBody2TextStyle.copyWith(color: Colors.white),
                ),
              ]),
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        enabled: true,
// hintText: '@gmail.com',
                        labelText: 'Medicine Name',
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    buildDrugTypeDropdown(),
                    const SizedBox(
                      height: 22,
                    ),
                    ListTile(
                      leading: SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            enabled: true,
                            labelText: 'Med Strength per $selectedDrugType',
                          ),
                        ),
                      ),
                      trailing: buildUnitsDropdown(),
                    ),
                    const SizedBox(
                      height: 267,
                    ),
                    CustomButton(
                      title: 'Next',
                      isButtonDisabled: false,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const MedicalCondition(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrugTypeDropdown() {
    return CustomDropdownButton(
      items: drugType,
      onChanged: (String? newValue) {
        setState(() {
          selectedDrugType = newValue!;
        });
      },
      dropdownValue: selectedDrugType,
      isExpanded: true,
    );
  }

  Widget buildUnitsDropdown() {
    return CustomDropdownButton(
      items: units,
      onChanged: (String? newValue) {
        setState(() {
          selectedUnit = newValue!;
        });
      },
      dropdownValue: selectedUnit,
      isExpanded: false,
    );
  }
}

// List<String> dosage = <String>[
//   'Once a day',
//   'Twice a day',
//   'Thrice a day',
//   '4 times a day',
//   'Every 1 hour',
//   'Every 6 hours',
//   'Other',
// ];

// Container(
// color: kPrimaryColor,
// child: Column(
// children: [
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// IconButton(
// icon: const Icon(
// Icons.close,
// color: Colors.white,
// ),
// onPressed: () {
// Navigator.of(context).pop();
// },
// ),
// const SizedBox(
// width: 75,
// ),
// const Text('Add Medication'),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 5),
// child: Container(
// decoration: const BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(20),
// topRight: Radius.circular(20),
// ),
// ),
// child: Column(
// children: [
// const TextField(
// decoration: InputDecoration(
// enabled: true,
// // hintText: '@gmail.com',
// labelText: 'Medicine Name',
// ),
// ),
// buildDrugTypeDropdown(),
// Row(
// children: [
// const TextField(
// decoration: InputDecoration(
// enabled: true,
// // hintText: '@gmail.com',
// labelText: 'Med Strength',
// ),
// ),
// buildUnitsDropdown(),
// ],
// ),
// CustomButton(title: 'Next', onPressed: () {}),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
