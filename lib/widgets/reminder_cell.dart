import 'package:flutter/material.dart';

class ReminderCell extends StatelessWidget {
  const ReminderCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [Text("Cell"), Spacer(), Text("11.03.22")],
    ));
  }
}
