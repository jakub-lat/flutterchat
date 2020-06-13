import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'chat.dart';
import 'db.dart';

class ChatSelector extends StatelessWidget {
  final List<String> chats = [
    'General'
  ];
  Widget buildCard(BuildContext context, DocumentSnapshot msg) {
    return Card(child: ListTile(
      leading: Column(children: [Icon(Icons.people)], mainAxisAlignment: MainAxisAlignment.center),
      title: Text(msg['name'], style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(msg['description']),
      trailing: IconButton(
        icon: Icon(Icons.more_horiz), 
        onPressed: (){

        }),
      onTap: () async {
        Navigator.pushNamed(context, '/chat', arguments: ChatData(msg.documentID));
      }
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              
            }
          )
        ]
      ),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.add),
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        onOpen: () {
          print('open');
        },
        children: [
          SpeedDialChild(
            child: Icon(Icons.create),
            label: 'Create',
            labelStyle: TextStyle(color: Colors.black),
            onTap: () {
              print('create');
              Navigator.of(context).pushNamed('/create');
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Join',
            labelStyle: TextStyle(color: Colors.black),
            onTap: () {
              print('join');
            }
          )
        ]
      ),
      body: Container(
        child: StreamBuilder(
          stream: db.guilds().snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if(snapshot.hasError) return Center(child: Text('Something went wrong!'));
            return ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, i) => buildCard(context, snapshot.data.documents[i])
            );
          }
      )
    ));
  }
}