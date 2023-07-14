import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/chat/repositories/chat_repository.dart';
import 'package:whatsapp_clone/models/chat_contact.dart';
import 'package:whatsapp_clone/models/message_model.dart';

final chatControllerProvider = Provider((ref) {
  final chatRespository = ref.watch(chatRespositoryProvider);
  return ChatController(chatRespository: chatRespository, ref: ref);
});

class ChatController {
  final ChatRespository chatRespository;
  final ProviderRef ref;

  ChatController({
    required this.chatRespository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRespository.getChatContacts();
  }

  Stream<List<MessageModel>> chatStream(String receiverUserId) {
    return chatRespository.getChatStream(receiverUserId);
  }

  void sendTextMessage(
      BuildContext context, String text, String receiverUserId) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRespository.sendTextMessage(
            context: context,
            text: text,
            receiverUserId: receiverUserId,
            senderUser: value!,
            messageReply: messageReply,
          ),
        );
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage(BuildContext context, File file, String receiverUserId,
      MessageEnum messageEnum) {
    final messageReply = ref.read(messageReplyProvider);

    ref.read(userDataAuthProvider).whenData(
          (value) => chatRespository.sendFileMessage(
            context: context,
            file: file,
            receiverUserId: receiverUserId,
            senderUserData: value!,
            ref: ref,
            messageEnum: messageEnum,
            messageReply: null,
          ),
        );
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String receiverUserId,
  ) {
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
    final messageReply = ref.read(messageReplyProvider);

    ref.read(userDataAuthProvider).whenData((value) => chatRespository.sendGIF(
        context: context,
        gifUrl: newgifUrl,
        receiverUserId: receiverUserId,
        senderUser: value!,
        messageReply: null));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }
}
