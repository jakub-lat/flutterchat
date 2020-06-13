import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'db.dart';

class CreateChannel extends StatefulWidget {
  final DocumentSnapshot guild;
  CreateChannel(this.guild);
  @override
  _CreateChannelState createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text('Create new channel', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Channel name',
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
                  if(nameController.text != '') {
                    await db.createChannel(widget.guild, nameController.text);
                  }
                },
              )
            ]
          )
        ]
      )
    );
  }
}