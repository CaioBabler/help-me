import 'package:help_me/models/person.dart';

class MessageModel {
  String messageText;
  Person owner;
  Person sender;
  DateTime sendDateTime;
  MessageModel({this.messageText, this.owner, this.sendDateTime, this.sender});

  Map<String, dynamic> toMap() {
    return {
      'messageText': messageText,
      'owner': {"id": owner.id, "name": owner.name},
      'sender': {"id": sender.id, "name": sender.name},
      'sendDateTime': DateTime.now(),
    };
  }

  factory MessageModel.fromMap(dynamic map) {
    if (map == null) return null;

    return MessageModel(
      messageText: map['messageText'],
      owner: Person.fromMap(map['owner']),
      sender: Person.fromMap(map['sender']),
      sendDateTime: DateTime.fromMicrosecondsSinceEpoch(
          map['sendDateTime'].microsecondsSinceEpoch),
    );
  }
}
