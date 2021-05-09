import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me/models/professional.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class ProfessionalRepository {
  Future<List<Professional>> getAllProfessionals() async {
    List<Professional> professionals = [];
    QuerySnapshot querySnapshot = await db.collection("professional").get();
    querySnapshot.docs.forEach((element) {
      professionals.add(Professional.fromMap(element));
    });

    return professionals;
  }
}
