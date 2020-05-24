import 'package:cloud_firestore/cloud_firestore.dart';
import 'sing_in.dart';

class Database {
  CollectionReference messages() {
    return Firestore.instance.collection('messages');
  }
  Query getMessages(String channel) {
    return messages().where('channel', isEqualTo: channel).orderBy('date').limit(20);
  }

  Future sendMessage(String channel, String content) async {
    if(content != '') {
      await db.messages().add({
        'channel': channel,
        'author': name,
        'content': content,
        'date': DateTime.now()
      });
    }
  }
}

var db = new Database();