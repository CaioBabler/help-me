import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_me/controllers/account_controller.dart';
import 'package:help_me/controllers/message_controller.dart';
import 'package:help_me/models/message_model.dart';
import 'package:help_me/models/person.dart';
import 'package:help_me/views/home.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

// ignore: must_be_immutable
class Message extends StatefulWidget {
  Person professional;

  Message({
    this.professional,
  });

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController txtMessage = new TextEditingController();
  MessageController messageController = new MessageController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final scrollDirection = Axis.vertical;
  AutoScrollController controller;

  final f = new DateFormat('hh:mm dd/MM/yyyy');
  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  _boxMessage() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                autocorrect: true,
                controller: txtMessage,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    hintText: "Digite sua menssagem",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32))),
              ),
            ),
          ),
          FloatingActionButton(
            mini: true,
            child: Icon(Icons.send, color: Colors.white),
            backgroundColor: Colors.yellow[700],
            onPressed: () async {
              var msg = txtMessage.text;
              txtMessage.clear();
              MessageModel sendMessage =
                  await messageController.sendMessage(msg, widget.professional);
            },
          ),
        ],
      ),
    );
  }

  _stream(BuildContext context) {
    return StreamBuilder(
      stream: db
          .collection("messages")
          .doc(AccountController.userAuth.id)
          .collection(widget.professional.id)
          .orderBy("sendDateTime")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> messages = snapshot.data.docs.toList();
          var teste = List<MessageModel>.from(
              messages.map((x) => MessageModel.fromMap(x))).toList();
          controller.scrollToIndex(snapshot.data.docs.length);
          return Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: controller,
                  index: index,
                  child: Align(
                    alignment:
                        AccountController.userAuth.id == teste[index].sender.id
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            decoration: BoxDecoration(
                                color: AccountController.userAuth.id ==
                                        teste[index].sender.id
                                    ? Color(0xfffeffa5)
                                    : Color(0xfffd3e2e5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    teste[index].messageText,
                                    style: TextStyle(color: Colors.grey[800]),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        f.format(teste[index].sendDateTime),
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 10),
                                      ))
                                ],
                              ),
                            ))),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.professional.name),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
          ),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              )),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/img/background_screen_menssage.png"),
          ),
        ),
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _stream(context),
              _boxMessage(),
            ],
          ),
        )),
      ),
    );
  }
}
