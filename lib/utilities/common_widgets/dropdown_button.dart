import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.dropdownValue,
    required this.items,
    required this.onChanged,
    required this.isExpanded,
    required this.title,
    required this.hintText,
  });
  final String dropdownValue;
  final String hintText;
  final String title;
  final bool isExpanded;
  final List<String> items;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),

      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 14),
      ),
  
      buttonStyleData: ButtonStyleData(
        height: 60,
        padding: const EdgeInsets.only(left: 20, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      iconStyleData: IconStyleData(
        icon: SvgPicture.asset(
          'assets/icons/arrowd.svg',
        ),
        iconSize: 30,
      ),

      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select $title.';
        }
      },
      onChanged: onChanged,
    );
  }
}

// (String? newValue){
// setState((){
// dropdownValue = newValue!;
// });
// },


// DropdownButton<String>(
// icon: SvgPicture.asset(
// 'assets/icons/arrowd.svg',
//
// ),
// isExpanded: isExpanded,
// value: dropdownValue,
// elevation: 16,
// // style: ,
// onChanged: onChanged,
// items: items.map<DropdownMenuItem<String>>(
// (String value) {
// return DropdownMenuItem(
// child: Text(value),
// value: value,
// );
// },
// ).toList(),
// ),

// (value) {
// //Do something when changing the item if you want.
// },
// onSaved: (value) {
// selectedValue = value.toString();
// },