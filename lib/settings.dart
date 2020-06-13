import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'sing_in.dart';
import 'db.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text = db.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings')
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Account', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder()), controller: usernameController),
            SizedBox(height: 10),
            Row(children:[
              RaisedButton(child: Text('Sign out'), 
                onPressed: () async {
                  await signOutGoogle();
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushReplacementNamed('/');
                  });
                }
              ),
              Expanded(child:SizedBox(width: 10)),
              RaisedButton(child: Text('Save changes'), 
                onPressed: () async {
                  if(usernameController.text != '')
                    await db.updateUser(username: usernameController.text);
                    Fluttertoast.showToast(
                      msg: 'Saved changes',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0
                  );
                }
              ),
            ])
            
          ])
      )
    );
  }
}