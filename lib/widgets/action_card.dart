import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ActionCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;

  const ActionCard({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        color: color == Colors.red ? Colors.red[300] : Colors.green[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: text == 'Delete' ? TextDirection.rtl : TextDirection.ltr,
          children: <Widget>[
            Icon(
              icon,
              color: color == Colors.red ? Colors.red[900] : Colors.green[900],
              size: 80.0,
            ),
            const Gap(10),
            Text(
              text,
              style: TextStyle(
                color: color == Colors.red ? Colors.red[900] : Colors.green[900],
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}