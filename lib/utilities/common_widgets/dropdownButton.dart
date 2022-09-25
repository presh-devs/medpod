import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton(
      {Key? key,
      required this.dropdownValue,
      required this.items,
      required this.onChanged,
      required this.isExpanded})
      : super(key: key);
  final String dropdownValue;
  final bool isExpanded;
  final List<String> items;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: isExpanded,
      value: dropdownValue,
      elevation: 16,
      // style: ,
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem(
            child: Text(value),
            value: value,
          );
        },
      ).toList(),
    );
  }
}

// (String? newValue){
// setState((){
// dropdownValue = newValue!;
// });
// },
