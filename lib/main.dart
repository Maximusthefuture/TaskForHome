import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/domain/notification_service.dart';
import 'package:tasks_for_home/presentation/screens/buy_list_screen.dart';
import 'package:tasks_for_home/presentation/screens/movies_series.dart';
import 'package:tasks_for_home/presentation/screens/reminder_screen.dart';
import 'package:tasks_for_home/presentation/screens/settings_screen.dart';
import "package:provider/provider.dart";
import 'package:firebase_core/firebase_core.dart';
import 'data/login_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<LoginState>(
      create: (context) => LoginState(), builder: (context, _) => Home()));
}




class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> _widgetsOptions = <Widget>[
    BuyListScreen(),
    MoviesTvSeries(),
    ReminderScreen(),
    SettingsScreeen(),
    Text('her her')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const bottomNavigationBarItem = BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: "Настройки",
    );
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("Home app"),
        // ),
        body: Center(
          child: _widgetsOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.red,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.transfer_within_a_station),
              label: "Покупки",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_movies),
              label: "Развлечения",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: "Напоминания",
            ),
            bottomNavigationBarItem,
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: CupertinoColors.activeBlue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
