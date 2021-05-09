import 'package:help_me/models/person.dart';

class TalkModel {
  Person owner;
  Person userAuth;
  DateTime creatAt;
  String lastMessage;
  TalkModel({
    this.owner,
    this.userAuth,
    this.creatAt,
    this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'owner': owner.toMap(),
      'userAuth': userAuth?.toMap(),
      'creatAt': creatAt,
      'lastMessage': lastMessage,
    };
  }

  factory TalkModel.fromMap(dynamic map) {
    if (map == null) return null;
    return TalkModel(
      owner: Person.fromMap(map['owner']),
      userAuth: Person.fromMap(map['userAuth']),
      lastMessage: map['lastMessage'],
      creatAt: DateTime.fromMicrosecondsSinceEpoch(
          map['creatAt'].microsecondsSinceEpoch),
    );
  }
}
