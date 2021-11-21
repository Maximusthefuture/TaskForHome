import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tasks_for_home/data/login_state.dart';
import 'package:tasks_for_home/domain/notification_service.dart';
import 'package:tasks_for_home/widgets/reminder_cell.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

var title = "";
var body = "";
var scheduledTime =
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

class _ReminderScreenState extends State<ReminderScreen> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder"),
        actions: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.add),
            onPressed: () {
              showAddItemMenu(context, myController, provider);
            },
          ),
        ],
      ),
      //TODO: ADD DATABASE!!!
      body: Container(
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ReminderCell();
              })),
    );
  }
}

Widget modalBottomShit(BuildContext context, TextEditingController myController,
    LoginState appState) {
  DateTime selectedDate = DateTime.now();
  // var dropdownValue = "Дом";
  return Container(
    height: MediaQuery.of(context).size.height / 6,
    // color: Colors.amber,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: "Fare cose"),
                controller: myController,
              )),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.flag)),
              IconButton(
                  onPressed: () {
                    _selectDate(context, selectedDate);
                    // showNotification(title, body, scheduledTime);
                    
                  },
                  icon: Icon(Icons.timer)),
              Spacer(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        child: Icon(Icons.send),
                        onTap: () {
                          print("Tap PRESS");
                          Navigator.pop(context);
                          myController.clear();
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return AlertDialog(
                                  title: Text("15 мин"),
                                );
                              });
                          print("LONG PRESS");
                        },
                      )))
            ],
          ),
        ],
      ),
    ),
  );
}

void showAddItemMenu(BuildContext context, TextEditingController myController,
    LoginState appState) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: modalBottomShit(context, myController, appState),
        );
      });
}

Future<Null> _selectDate(BuildContext context, DateTime selectedDate) async {
  TextEditingController _dateController = TextEditingController();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2021),
      lastDate: DateTime(2101));
  if (picked != null) {
    // setState(() {
    selectedDate = picked;
    _dateController.text = DateFormat.yMd().format(selectedDate);
  }
  print("DATE IS ${_dateController.text}");
}

void showNotification(String title, String body, var time) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('ReminderID', 'ReminderChannel' , 'Reminder',
          importance: Importance.max, priority: Priority.high, showWhen: false);

  const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(
    presentAlert:
        true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
    presentBadge:
        true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
    presentSound:
        true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)  // Specifics the file path to play (only from iOS 10 onwards)
    badgeNumber: 0, // The application's icon badge number
  );
  var platformSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  tz.initializeTimeZones();

  await NotificationService.flutterLocalNotificationsPlugin.zonedSchedule(
      0, title, body, time, platformSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true);  
}
