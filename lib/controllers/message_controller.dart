import 'package:help_me/controllers/account_controller.dart';
import 'package:help_me/models/message_model.dart';
import 'package:help_me/models/person.dart';
import 'package:help_me/models/talk_model.dart';
import 'package:help_me/repository/message_repository.dart';

class MessageController {
  AccountController accountController = new AccountController();
  MessageRepository messageRepository = new MessageRepository();

  sendMessage(String message, Person owner) async {
    MessageModel messageModel = new MessageModel(
        messageText: message, owner: owner, sender: AccountController.userAuth);
    bool response = await messageRepository.sendMessage(
        messageModel, messageModel.sender, messageModel.owner);
    bool responseOwner = await messageRepository.sendMessage(
        messageModel, messageModel.owner, messageModel.sender);
    await saveTalk(
        TalkModel(
            creatAt: DateTime.now(),
            lastMessage: message,
            owner: owner,
            userAuth: AccountController.userAuth),
        AccountController.userAuth,
        owner);
    if (response && responseOwner)
      return MessageModel(
          messageText: message,
          owner: owner,
          sender: AccountController.userAuth);
    else
      return null;
  }

  saveTalk(TalkModel talkmodel, Person sender, Person owner) async {
    await messageRepository.saveTalk(talkmodel, sender, owner);
    await messageRepository.saveTalk(talkmodel, owner, sender);
  }
}
