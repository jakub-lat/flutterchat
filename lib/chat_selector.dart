import 'package:flutter/material.dart';

class ChatSelector extends StatelessWidget {
  final List<String> chats = [
    'General'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Communities'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              
            }
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

        },
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(5),
          itemCount: chats.length,
          itemBuilder: (context, i) {
            return Card(child: ListTile(
              leading: Column(children: [Icon(Icons.people)], mainAxisAlignment: MainAxisAlignment.center),
              title: Text(chats[i], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Some community'),
              onTap: () {
                Navigator.pushNamed(context, '/chat', arguments: chats[i]);
              }
            ));
        })
      ));
  }
}