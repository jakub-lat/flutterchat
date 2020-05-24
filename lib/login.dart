import 'package:flutter/material.dart';
import 'sing_in.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat App')),
      body: Container(
      padding: EdgeInsets.all(50),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Text('Sign in with google', 
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            RaisedButton(
              child: Row(children: [
                Text('Sign in', style: TextStyle(color: Colors.white, fontSize: 17)),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward, color: Colors.white),
              ], mainAxisSize: MainAxisSize.min),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                try {
                  await signInWithGoogle();
                  Navigator.pushReplacementNamed(context, '/home');
                } catch(err) {
                  print('failed');
                }
              })
          ])),
      )
    );
  }
}