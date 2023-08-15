import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    Key? key,
    required this.dropdownValue,
    required this.items,
    required this.onChanged,
    required this.isExpanded,
    required this.title,
    required this.hintText,
  }) : super(key: key);
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
//Add isDense true and zero Padding.
//Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
//Add more decoration as you want here
//Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 14),
      ),
      icon: SvgPicture.asset(
        'assets/icons/arrowd.svg',
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 16),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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