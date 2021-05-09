import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me/models/message_model.dart';
import 'package:help_me/models/person.dart';
import 'package:help_me/models/talk_model.dart';

class MessageRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> sendMessage(
      MessageModel message, Person sender, Person owner) async {
    try {
      await db
          .collection("messages")
          .doc(sender.id)
          .collection(owner.id)
          .add(message.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveTalk(
      TalkModel talkModel, Person sender, Person owner) async {
    try {
      await db
          .collection("talks")
          .doc(sender.id)
          .collection("lasttalk")
          .doc(owner.id)
          .set(talkModel.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }
}
