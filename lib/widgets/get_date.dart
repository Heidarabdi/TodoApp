
// get date picker

import 'package:flutter/material.dart';

Future<DateTime?> getDatePicker(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
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
