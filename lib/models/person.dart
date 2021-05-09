class Person {
  String id;
  String name;
  Person({this.id, this.name});
  factory Person.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Person(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
