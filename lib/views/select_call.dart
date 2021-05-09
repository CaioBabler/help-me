import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_me/components/componets.dart';
import 'package:help_me/controllers/account_controller.dart';
import 'package:help_me/models/appointment_model.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';

class SelectCall extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectCallState();
}

class SelectCallState extends State<SelectCall> {
  final _channelController = TextEditingController();

  ClientRole _role = ClientRole.Broadcaster;
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  _stream(BuildContext context) {
    return StreamBuilder(
      stream: db
          .collection("appointment")
          .doc(AccountController.userAuth.id)
          .collection(AccountController.userAuth.id)
          .where("sendDateTime", isGreaterThanOrEqualTo: DateTime.now())
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
                if (teste[index].type == "videoconferência")
                  return GestureDetector(
                    onTap: () => onJoin(
                        teste[index].professional.id + teste[index].patient.id,
                        teste[index].professional.name),
                    child: Padding(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Data Solicitada :${formatDate.format(teste[index].dateAppointment)}"),
                                  Text("Período :${teste[index].timeCourse}"),
                                ],
                              ),
                              Text("Tipo :${teste[index].type}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                else
                  return Container();
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
    return _stream(context);
  }

  Future<void> onJoin(String channelCall, String professionalName) async {
    // update input validation

    //permissions
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: "help-me",
          role: _role,
          owner: professionalName,
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
