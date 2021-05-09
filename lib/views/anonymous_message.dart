import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_me/controllers/account_controller.dart';
import 'package:help_me/controllers/message_controller.dart';
import 'package:help_me/models/message_model.dart';
import 'package:help_me/models/professional.dart';
import 'package:help_me/models/talk_model.dart';
import 'package:help_me/views/add_conversation.dart';
import 'package:intl/intl.dart';

import 'message.dart';

class AnonymousMessage extends StatefulWidget {
  AnonymousMessage({Key key}) : super(key: key);

  @override
  _AnonymousMessageState createState() => _AnonymousMessageState();
}

class _AnonymousMessageState extends State<AnonymousMessage> {
  MessageController messageController = new MessageController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _controller = StreamController<QuerySnapshot>.broadcast();
  final f = new DateFormat('hh:mm dd/MM/yyyy');

  Professional professional;
  List<MessageModel> messagesNew;
  @override
  // ignore: must_call_super
  void initState() {
    _addListener();
  }

  Stream<QuerySnapshot> _addListener() {
    final stream = db
        .collection("talks")
        .doc(AccountController.userAuth.id)
        .collection("lasttalk")
        .snapshots();
    stream.listen((event) {
      _controller.add(event);
    });
  }

  _stream(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> talks = snapshot.data.docs.toList();

          var teste =
              List<TalkModel>.from(talks.map((x) => TalkModel.fromMap(x)))
                  .toList();

          return Expanded(
            child: ListView.builder(
              itemCount: teste.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Message(professional: teste[index].owner),
                        )),
                    title: Text(teste[index].owner.name),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(teste[index].userAuth.id ==
                                AccountController.userAuth.id
                            ? "Você: ${teste[index].lastMessage}"
                            : "${teste[index].owner.name + ":" + teste[index].lastMessage}"),
                        Text(f.format(teste[index].creatAt),
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 10)),
                      ],
                    ));
              },
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Carregando conversa..."),
                )
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_stream(context)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddConversation(),
              ));
        },
      ),
    );
  }
}
