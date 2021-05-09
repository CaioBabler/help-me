import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_me/models/person.dart';

class UserModel implements Person {
  String password;
  String email;

  @override
  String name;

  @override
  String id;
  UserModel({
    this.password,
    this.email,
    this.name,
    this.id,
  });

  factory UserModel.fromUser(User user) {
    if (user == null) return null;

    return UserModel(
      email: user.email,
      name: user.displayName,
      id: user.uid,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
    };
  }
}
