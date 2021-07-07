import 'package:flutter/material.dart';

class ReminderCell extends StatelessWidget {
  const ReminderCell({Key? key}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Заплатить за квартиру",
                      textScaleFactor: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Center(child: Text("22.03"))
              ],
            ),
          ),
        ));
  }
}
