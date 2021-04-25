import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SomeShit"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Shit"),
            Text("Shit2"),
            Row(
              children: [
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  
                  Text("column"),
                 
                ]),
                 IconButton(icon: Icon(Icons.camera_alt), onPressed: () {
                    //Open camera here

                 })
              ],
            )
          ],
        ),
      ),
    );
  }
}
