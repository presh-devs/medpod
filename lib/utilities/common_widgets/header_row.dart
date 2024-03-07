

import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

Row buildHeaderRow({required String title,required String imageUrl}) {
  return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    Text(title + imageUrl,style: kSmallBody3TextStyle.copyWith(color: Colors.black)),
    // Image.asset(imageUrl),
  ]);
}

Row buildHeaderRow1({required String title,required String imageUrl}) {

  return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    Text(title, style: kSmallBody3TextStyle.copyWith(color: Colors.black),),
   
    Image.asset(imageUrl),
  ]);
}