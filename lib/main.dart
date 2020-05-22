import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/screens/movies_series.dart';

void main() => runApp(Home());


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}

class HomeState extends State<Home> {
int _selectedIndex = 0;
static  List<Widget> _widgetsOptions = <Widget>[
  Text('Index 0: Home'),
  MoviesTvSeries(),
  Text('Index 1: Business'),
  Text('Index 2: School'),
  Text('her her')
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
   
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
                title: Text("Покупки"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_movies),
                title: Text("Развлечения"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                title: Text("Напоминания"),
              ),
               BottomNavigationBarItem(
                icon: Icon(Icons.settings,),
                title: Text("Настройки"),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: CupertinoColors.activeBlue,
            onTap: _onItemTapped,
          ),
        ),
    );
  }

}