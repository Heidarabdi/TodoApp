
// get timepicker

import 'package:flutter/material.dart';

Future<TimeOfDay?> getTimePicker(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
          ),
        ),
        child: child!,
      );
    },
  );
  return picked;
}