import 'dart:async';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_me/components/componets.dart';
import 'package:help_me/controllers/account_controller.dart';
import 'package:help_me/controllers/appointment_controller.dart';
import 'package:help_me/controllers/professional_controller.dart';
import 'package:help_me/models/appointment_model.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Appointment extends StatefulWidget {
  Appointment({Key key}) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  DateTime now = new DateTime.now();
  ProfessionalController professionalController = new ProfessionalController();
  AppointmentModel appointment = new AppointmentModel();
  AppointmentController appointmentController = AppointmentController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  String professionalSelect;
  Future<bool> loadProfessionals;

  @override
  void initState() {
    super.initState();
    loadProfessionals = professionalController.getAllProfessionals();
  }

  _stream(BuildContext context) {
    return StreamBuilder(
      stream: db
          .collection("appointment")
          .doc(AccountController.userAuth.id)
          .collection(AccountController.userAuth.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> appointment = snapshot.data.docs.toList();
          var teste = List<AppointmentModel>.from(
              appointment.map((x) => AppointmentModel.fromMap(x))).toList();
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Material(
                    color: Colors.white70,
                    elevation: 2,
                    //borderRadius: BorderRadius.circular(15.0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[100], width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Psicólogo :${teste[index].professional.name}")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Data Solicitada :${formatDate.format(teste[index].dateAppointment)}"),
                              Text("Período :${teste[index].timeCourse}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Status :${teste[index].status}"),
                              Text("Tipo :${teste[index].type}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Expanded(child: Container());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: loadProfessionals,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Column(
              children: [
                _stream(context),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.event_sharp),
              onPressed: () {
                return showMaterialModalBottomSheet(
                  enableDrag: true,
                  context: context,
                  builder: (context) {
                    appointment.dateAppointment = DateTime.now();
                    return StatefulBuilder(builder: (BuildContext context,
                        StateSetter setState /*You can rename this!*/) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Divider(
                              indent: size.width * 0.4,
                              thickness: 1,
                              color: Colors.grey[800],
                              endIndent: size.width * 0.4,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 5),
                                child: Text("Escolha um data"),
                              ),
                            ),
                            CalendarTimeline(
                              initialDate: appointment.dateAppointment,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime(now.year, now.month, now.day + 5),
                              onDateSelected: (date) =>
                                  appointment.dateAppointment = date,
                              leftMargin: 20,
                              monthColor: Colors.blueGrey,
                              dayColor: Colors.teal[200],
                              activeDayColor: Colors.white,
                              activeBackgroundDayColor: Colors.redAccent[100],
                              dotsColor: Color(0xFF333A47),
                              selectableDayPredicate: (date) => date.day != 23,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 5),
                                child: Text("Escolha o período"),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<String>(
                                  items: <String>[
                                    'Matutino',
                                    'Vespertino',
                                    'Noturno'
                                  ].map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      appointment.timeCourse = value;
                                    });
                                  },
                                  hint: Text(appointment.timeCourse ?? "Turno"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                DropdownButton(
                                  items: professionalController.professionals
                                      .map((value) {
                                    return new DropdownMenuItem<String>(
                                      value: value.name,
                                      child: new Text(value.name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      appointment.professional =
                                          professionalController.professionals
                                              .firstWhere((element) =>
                                                  element.name == value);
                                      professionalSelect =
                                          appointment.professional.name;
                                    });
                                  },
                                  hint: Text(professionalSelect ??
                                      "Escolha um Psicólogo"),
                                ),
                              ],
                            ),
                            DropdownButton<String>(
                              items: <String>['Presencial', 'videoconferência']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  appointment.type = value;
                                });
                              },
                              hint: Text(appointment.type ?? "Tipo"),
                            ),
                            SizedBox(height: 20),
                            RoundedLoadingButton(
                              child: Text("Solicitar horário",
                                  style: TextStyle(color: Colors.white)),
                              controller: _btnController,
                              onPressed: () async {
                                var response = await appointmentController
                                    .setAppointment(appointment);
                                if (response) {
                                  _btnController.success();
                                  Navigator.pop(context);
                                } else {
                                  _btnController.error();
                                  Future.delayed(Duration(seconds: 2),
                                      () => _btnController.reset());
                                }
                              },
                              color: Colors.yellow[800],
                            ),
                          ],
                        ),
                      );
                    });
                  },
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
