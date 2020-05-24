import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chat.dart';
import 'login.dart';
import 'home.dart';
import 'settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context)=>Login(),
        '/home': (context)=>Home(),
        '/chat': (context)=>Chats(),
        '/account': (context)=>Settings()
      }
    );
  }
}


