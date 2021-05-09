import 'package:flutter/material.dart';
import 'package:help_me/controllers/message_controller.dart';
import 'package:help_me/controllers/professional_controller.dart';
import 'package:help_me/views/message.dart';

class AddConversation extends StatefulWidget {
  AddConversation({Key key}) : super(key: key);

  @override
  _AddConversationState createState() => _AddConversationState();
}

class _AddConversationState extends State<AddConversation> {
  ProfessionalController professionalController = new ProfessionalController();
  MessageController message = new MessageController();
  Future<bool> loadProfessionals;
  @override
  void initState() {
    super.initState();
    loadProfessionals = professionalController.getAllProfessionals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de profissionais")),
      body: FutureBuilder(
        future: loadProfessionals,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Message(
                                professional:
                                    professionalController.professionals[index],
                              ),
                            ),
                          ),
                      title: Text(
                          professionalController.professionals[index].name),
                      subtitle: Text(
                          professionalController.professionals[index].city));
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: professionalController.professionals.length);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
