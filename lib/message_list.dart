import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db.dart';

class MessageList extends StatefulWidget {
  final DocumentSnapshot channel;
  final DocumentSnapshot guild;
  MessageList(this.guild, this.channel);

  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  final messageController = TextEditingController();
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Widget buildMessage(BuildContext context, DocumentSnapshot msg) {
    Timestamp date = msg['date'];
    var formatter = new DateFormat('dd.MM HH:mm');
    return Container(
      padding: EdgeInsets.all(5),
      child: FutureBuilder<DocumentSnapshot>(
        future: db.getUser(msg['author']).get(),
        builder: (context, result) {
          if(result.connectionState == ConnectionState.waiting) return Center(child: LinearProgressIndicator());
          if(result.hasError || !result.hasData || !result.data.exists) return Text('ERROR');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(formatter.format(date.toDate()), style: TextStyle(fontSize: 12, color: Colors.grey)),
              Row(children: <Widget>[
                Text(result.data['username'] + ': ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(msg['content'])
              ]),
          ]);
        }
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.messageList(widget.guild.documentID, widget.channel.documentID).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasError) return Text('Error');
        if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
        return ListView.separated(
          controller: scrollController,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) =>
            buildMessage(context, snapshot.data.documents[index]),
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      }
    );
  }
}
