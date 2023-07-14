import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/models/message_model.dart';
import 'package:whatsapp_clone/features/chat/widgets/my_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({required this.receiverUserId, super.key});

  final String receiverUserId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();
  

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.notifier).update((state) =>
        MessageReply(message: message, isMe: isMe, messageEnum: messageEnum),);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
        stream:
            ref.read(chatControllerProvider).chatStream(widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);

              return MyMessageCard(
                message: messageData.text,
                date: timeSent,
                index: index,
                messageData: messageData,
                username: messageData.repliedTo,
                repliedMessageType: messageData.repliedMessageType,
                repliedText: messageData.repliedMessage, 
                type: messageData.type,
                onLeftSwipe: ()=> onMessageSwipe(messageData.text, true, messageData.type,), 
                onRightSwipe: () => onMessageSwipe(messageData.text, false, messageData.type,),
              );
            },
          );
        });
  }
}