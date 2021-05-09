import 'package:help_me/models/professional.dart';
import 'package:help_me/repository/professional_repository.dart';

class ProfessionalController {
  List<Professional> professionals = [];
  ProfessionalRepository professionalRepository = new ProfessionalRepository();
  Future<bool> getAllProfessionals() async {
    professionals = await professionalRepository.getAllProfessionals();
    return true;
  }
}
