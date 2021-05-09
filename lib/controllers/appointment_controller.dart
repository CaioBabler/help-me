import 'package:help_me/models/appointment_model.dart';
import 'package:help_me/repository/appointment_repository.dart';

import 'account_controller.dart';

class AppointmentController {
  AppointmentRepository _appointmentRepository = AppointmentRepository();
  setAppointment(AppointmentModel appointment) async {
    appointment.patient = AccountController.userAuth;
    bool reponse = await _appointmentRepository.setAppointment(
        appointment, appointment.patient, appointment.professional);
    bool reponseProdession = await _appointmentRepository.setAppointment(
        appointment, appointment.professional, appointment.patient);
    return reponse && reponseProdession;
  }
}
