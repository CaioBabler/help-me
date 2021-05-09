import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me/models/appointment_model.dart';
import 'package:help_me/models/person.dart';

class AppointmentRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  setAppointment(
      AppointmentModel appointment, Person person1, Person person2) async {
    try {
      await db
          .collection("appointment")
          .doc(person1.id)
          .collection(person1.id)
          .add(appointment.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  getAppointment() {}
}
