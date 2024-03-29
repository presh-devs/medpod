import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medpod/views/medical_condition.dart';
import 'package:medpod/utilities/common_widgets/button.dart';
import '../utilities/common_widgets/alinged_text.dart';
import '../utilities/common_widgets/dropdown_button.dart';
import '../utilities/common_widgets/header_row.dart';
import '../utilities/common_widgets/progress_indicator.dart';
import '../utilities/constants/button_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

enum MedUnits {
  grams('g', "grams"),
  internationalUnit('IU', "internationalUnit"),
  milligrams('mg', "milligrams"),
  milliliter('ml', "milliliter"),
  millieequivalent('mEq', "millieequivalent"),
  percentage('%', "percentage"),
  unit('Unit', "unit");

  const MedUnits(this.label, this.meaning);
  final String label;
  final String meaning;
}

class AddMed extends StatefulWidget {
  const AddMed({super.key});

  @override
  State<AddMed> createState() => _AddMedState();
}

class _AddMedState extends State<AddMed> {
  final TextEditingController medicine = TextEditingController();
  final TextEditingController quantity = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          CustomProgressIndicator(
            width: width,
            progress: '1/4',
            percent: 0.25,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    buildHeaderRow1(
                        title: 'Add Medication',
                        imageUrl: 'assets/icons/med.png'),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Medicine Name')),
              SizedBox(
                height: height * 0.015,
              ),
              TextField(
                controller: medicine,
                decoration: const InputDecoration(
                  enabled: true,
                  border: kBorder,
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              const AlignedText(text: 'Medicine Type'),
              SizedBox(
                height: height * 0.01,
              ),
              buildDrugTypeDropdown(),
              SizedBox(
                height: height * 0.04,
              ),
              const AlignedText(text: 'Medicine Unit'),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: 65,
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: width * 0.35,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16),
                        child: TextField(
                          controller: quantity,
                          decoration: const InputDecoration(
                            enabled: true,
                            // labelText: 'Med Strength per $selectedDrugType',
                            // border:  kBorder,
                          ),
                        ),
                      ),
                    ),
                    DropdownMenu<MedUnits>(
                      inputDecorationTheme: InputDecorationTheme(border: InputBorder.none,  isDense: true),
                        initialSelection: MedUnits.grams,
                        onSelected: (MedUnits? unit) {
                          selectedUnit = unit!.label;
                        },
                        dropdownMenuEntries: MedUnits.values
                            .map<DropdownMenuEntry<MedUnits>>(
                                (MedUnits unit) => DropdownMenuEntry(
                                    value: unit, label: unit.label))
                            .toList()),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.085,
              ),
              CustomButton(
                title: 'Next',
                isButtonDisabled: medicine.text.isEmpty ? true : false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) => MedicalCondition(
                          medName: medicine.text,
                          selectedDrugType: selectedDrugType,
                          selectedUnit: selectedUnit,
                          quantity: quantity.text),
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
      title: 'Medicine Type',
      hintText: 'Select Medicine Type',
    );
  }

  Widget buildUnitsDropdown() {
    return SizedBox(
      width: 40,
      child: CustomDropdownButton(
          dropdownValue: selectedUnit,
          items: units,
          onChanged: (value) {
            setState(() {
              selectedUnit = value as String;
            });
          },
          isExpanded: false,
          title: '',
          hintText: ''),
    );

    // DropdownButtonHideUnderline(
    //   child: DropdownButton2(
    //     customButton: SvgPicture.asset(
    //       'assets/icons/arrowd.svg',
    //     ),
    //     hint: Text(
    //       'mg',
    //       style: TextStyle(
    //         fontSize: 14,
    //         color: Theme.of(context).hintColor,
    //       ),
    //     ),
    //     items: units
    //         .map((item) => DropdownMenuItem<String>(
    //               value: item,
    //               child: Text(
    //                 item,
    //                 style: const TextStyle(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //             ))
    //         .toList(),
    //     value: selectedUnit,
    //     onChanged: (value) {
    //       setState(() {
    //         selectedUnit = value as String;
    //       });
    //     },
    //     buttonStyleData: const ButtonStyleData(
    //       height: 40,
    //     width: 60,
    //     ),
    //     menuItemStyleData: const MenuItemStyleData(
    //       height: 60,
    //     ),
    //   ),
    // );
  }
}

// CustomDropdownButton(
// items: units,
// onChanged: (String? newValue) {
// setState(() {
// selectedUnit = newValue!;
// });
// },
// dropdownValue: selectedUnit,
// isExpanded: false, title: 'Unit', hintText: 'Please select unit',
// );

// DropdownButtonHideUnderline(
// child: DropdownButton2(
// hint: Text(
// 'Select Item',
// style: TextStyle(
// fontSize: 14,
// color: Theme
//     .of(context)
//     .hintColor,
// ),
// ),
// items: items
//     .map((item) =>
// DropdownMenuItem<String>(
// value: item,
// child: Text(
// item,
// style: const TextStyle(
// fontSize: 14,
// ),
// ),
// ))
//     .toList(),
// value: selectedValue,
// onChanged: (value) {
// setState(() {
// selectedValue = value as String;
// });
// },
// buttonHeight: 40,
// buttonWidth: 140,
// itemHeight: 40,
// ),
// ),
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
