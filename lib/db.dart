import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  String uid;
  String email;
  String username;

  CollectionReference guilds() => Firestore.instance.collection('guilds');
  CollectionReference users() => Firestore.instance.collection('users');

  DocumentReference getChannel(String guild, String channel) {
    var g = guilds().document(guild);
    var c = g.collection('channels').document(channel);
    return c;
  }
  CollectionReference getMessages(String guild, String channel) {
    return getChannel(guild, channel).collection('messages');
  }

  Query messageList(String guild, String channel) {
    return getMessages(guild, channel).orderBy('date');
  }

  Future sendMessage(String guild, String channel, String content) async {
    if(content != '') {
      await getMessages(guild, channel).add({
        'channel': channel,
        'author': uid,
        'content': content,
        'date': DateTime.now()
      });
    }
  }

  Future<DocumentSnapshot> createChat(String name, String description) async {
    var chat = await guilds().add({
      'name': name,
      'description': description
    });
    await chat.collection('channels').add({
      'name': 'General'
    });
    return await chat.get();
  }

  Future<DocumentSnapshot> createChannel(DocumentSnapshot chat, String name) async {
    var channel = await chat.reference.collection('channels').add({
      'name': name
    });
    return await channel.get();
  }

  Future signIn(String email, String name) async {
    var ulist = (await users().where('email', isEqualTo: email).limit(1).getDocuments()).documents;
    print(ulist.length);
    if(ulist.length != 0) {
      this.email = email;
      this.username = ulist[0]['username'];
      this.uid = ulist[0].documentID;
    } else {
      var u = await users().add({
        'email': email,
        'username': name
      });
      this.email = email;
      this.username = name;
      this.uid = u.documentID;
    }
  }

  Future updateUser({String username}) async {
    await users().document(uid).updateData({
      'username': username
    });
    this.username = username;
  }

  DocumentReference getUser(String uid) {
    return users().document(uid);
  }
}

var db = new Database();