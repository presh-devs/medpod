import 'dart:core';

import 'package:flutter/material.dart';
import 'package:medpod/utilities/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../views/sign_in/sign_in_form.dart';

class CalCard extends StatefulWidget {
  const CalCard({super.key});

  @override
  State<CalCard> createState() => _CalCardState();
}

class _CalCardState extends State<CalCard> {
  var height = logicalScreenSize.height;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height * 0.20,
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now().subtract(const Duration(days: 30)),
                  lastDay: DateTime.now().add(const Duration(days: 30)),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                  calendarFormat: CalendarFormat.week,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  calendarStyle: const CalendarStyle(

                    todayDecoration: BoxDecoration(
                      color: kPrimaryColor,
                      // shape: BoxShape.rectangle,
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(8),
                      // ),
                    ),
                    selectedDecoration: BoxDecoration(
                      color: kPrimaryColor,
                      // shape: BoxShape.rectangle,
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(8),
                      // ),
                    ),

                  ),
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kPrimaryColor1,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                    todayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
