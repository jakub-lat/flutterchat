import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'message_list.dart';
import 'create_channel.dart';
import 'db.dart';

class ChatData {
  final String guildID;
  ChatData(this.guildID);
}

class Chats extends StatefulWidget {
  final ChatData chat;
  Chats(this.chat);

  ChatsState createState() => ChatsState();
}

class ChatsState extends State<Chats> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int tabIndex = 0;
  bool showMsgField = true;
  bool loaded = false;
  final TextEditingController messageController = new TextEditingController();

  DocumentSnapshot guild;
  List<DocumentSnapshot> channels;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  Future initAsync() async {
    guild = await db.guilds().document(widget.chat.guildID).get();
      channels = (await guild.reference.collection('channels').getDocuments()).documents;
      _tabController = new TabController(vsync: this, length: channels.length+1);
      _tabController.addListener(_setActiveTabIndex);
      loaded = true;
    setState(() {});
  }

  void _setActiveTabIndex() async {
    setState((){
      tabIndex = _tabController.index;
      showMsgField = tabIndex < channels.length;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future send() async {
    await db.sendMessage(guild.documentID, channels[tabIndex].documentID, messageController.text);
    messageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    if(!loaded) return Scaffold(
      appBar: AppBar(
        title: Text('Loading...')
      ),
      body: Center(child: CircularProgressIndicator())
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(guild['name']),
            Text(tabIndex >= channels.length ? 'New channel' : channels[tabIndex]['name'], style: TextStyle(color: Colors.white70, fontSize: 15)),
          ]),
        actions: [
          PopupMenuButton(
            tooltip: 'More actions',
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Settings'),
                  value: 'settings'
                )
              ];
            }
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            for(var tab in channels) Tab(text: tab['name']),
            Tab(icon: Icon(Icons.add))
          ], isScrollable: true),
      ),
      body: Column(children: [
        Expanded(child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            for(var tab in channels) MessageList(guild, tab),
            CreateChannel(guild)
          ])),
        showMsgField ? Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type something',
                  hintStyle: TextStyle(color: Colors.white70),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white10,
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.multiline,
                controller: messageController,
              )),
            IconButton(icon: Icon(Icons.send), onPressed: send, tooltip: 'Send',)
        ])) : Container()
      ]
    ));
  }
}