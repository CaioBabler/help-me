import 'package:help_me/models/person.dart';

class AppointmentModel {
  String type;
  String timeCourse;
  Person professional;
  Person patient;
  DateTime dateAppointment;
  String status;
  AppointmentModel(
      {this.type,
      this.timeCourse,
      this.professional,
      this.patient,
      this.dateAppointment,
      this.status});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'timeCourse': timeCourse,
      'professional': professional.toMap(),
      'patient': patient.toMap(),
      'sendDateTime': dateAppointment,
      'status': status ?? "PENDENTE"
    };
  }

  factory AppointmentModel.fromMap(dynamic map) {
    return AppointmentModel(
        type: map['type'],
        timeCourse: map['timeCourse'],
        professional: Person.fromMap(map['professional']),
        patient: Person.fromMap(map['patient']),
        dateAppointment: DateTime.fromMicrosecondsSinceEpoch(
            map['sendDateTime'].microsecondsSinceEpoch),
        status: map['status']);
  }
}
