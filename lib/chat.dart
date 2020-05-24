import 'package:flutter/material.dart';
import 'message_list.dart';
import 'db.dart';

class ChatData {
  final String name;
  ChatData({this.name});
}

class Chats extends StatefulWidget {
  ChatsState createState() => ChatsState();
}

class ChatsState extends State<Chats> with SingleTickerProviderStateMixin {
  final chats = <ChatData>[
    ChatData(name: 'main'),
    ChatData(name: 'second'),
    ChatData(name: 'general'),
    ChatData(name: 'offtopic'),
    ChatData(name: 'something'),
    ChatData(name: 'another')
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: chats.length);
    _tabController.addListener(_setActiveTabIndex);
  }

  void _setActiveTabIndex() {
    setState((){});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final TextEditingController messageController = new TextEditingController();

  Future send() async {
    await db.sendMessage(chats[_tabController.index].name, messageController.text);
    messageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings.arguments);
    final String chat = ModalRoute.of(context).settings.arguments ?? 'oops';

    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(chat),
          Text(chats[_tabController.index].name, style: TextStyle(color: Colors.white70, fontSize: 15)),
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
          for(var tab in chats) Tab(text: tab.name)
        ], isScrollable: true),
      ),
      body: Column(children: [
        Expanded(child: TabBarView(
          controller: _tabController,
          children: <Widget>[
          for(var tab in chats) MessageList(channel: tab.name)
        ])),
        Padding(
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
          ]))
      ]
    ));
  }
}