import 'package:flutter/material.dart';
import 'chat.dart';
import 'db.dart';

class CreateChat extends StatefulWidget {
  @override
  _CreateChatState createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create new chat')),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  padding: EdgeInsets.all(10),
                  child: Text('Create', style: TextStyle(fontSize: 15)),
                  onPressed: () async {
                    if(nameController.text != '' && descriptionController.text != '') {
                      var chat = await db.createChat(nameController.text, descriptionController.text);
                      Navigator.pushReplacementNamed(context, '/chat', arguments: ChatData(chat.documentID));
                    }
                  },
                )
              ]
            )
            
          ],
        )
      ),
    );
  }
}