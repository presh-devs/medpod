import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

SizedBox buildCalendarCard(double height) {
  return SizedBox(
      height: height * 0.17,
      child: Card(
        elevation: 1,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: EdgeInsets.all(height * 0.01),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('September, 2022'),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/calendar-2.svg',

                      //width: 230,
                      //height: 235,
                    ),
                    tooltip: '',
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ));
}