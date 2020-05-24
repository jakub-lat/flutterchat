import 'package:flutter/material.dart';
import 'settings.dart';
import 'chat_selector.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  int tabIndex = 0;

  final List<Widget> children = [
    ChatSelector(),
    Text('null'),
    Settings()
  ];

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int i) {
    setState(() {
      tabIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Community')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_satisfied),
            title: Text('Friends')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings')
          )
        ]
      ),
    );
  }
}