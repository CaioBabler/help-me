import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me/models/person.dart';

class Professional implements Person {
  @override
  String name;
  String city;
  Professional({
    this.id,
    this.name,
    this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'id': id,
    };
  }

  factory Professional.fromMap(QueryDocumentSnapshot map) {
    if (map == null) return null;
    return Professional(
      id: map.id,
      name: map['name'],
      city: map['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Professional.fromJson(String source) =>
      Professional.fromMap(json.decode(source));

  @override
  String id;
}
