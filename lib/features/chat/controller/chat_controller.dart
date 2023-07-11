import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/chat/repositories/chat_repository.dart';

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

  void sendTextMessage(
      BuildContext context, String text, String receiverUserId) {
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRespository.sendTextMessage(
            context: context,
            text: text,
            receiverUserId: receiverUserId,
            senderUser: value!));
  }
}
