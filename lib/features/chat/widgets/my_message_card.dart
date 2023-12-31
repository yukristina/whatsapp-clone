import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/features/chat/widgets/display_text_image_gif.dart';
import 'package:whatsapp_clone/models/message_model.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({
    super.key,
    required this.message,
    required this.date,
    required this.index,
    required this.messageData,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
    required this.onRightSwipe,
    required this.isSeen,
  });

  final String message;
  final String date;
  final int index;
  final MessageModel messageData;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final VoidCallback onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    final isSender =
        (messageData.senderId == FirebaseAuth.instance.currentUser!.uid);

    final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onLeftSwipe: isSender ? onLeftSwipe : null,
      onRightSwipe: isSender ? null : onRightSwipe,
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: isSender ? messageColor : senderMessageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: type == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          top: 5,
                          right: 5,
                          bottom: 25,
                        ),
                  child: Column(
                    children: [
                      if (isReplying) ...[
                        Text(
                          username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: backgroundColor.withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: DisplayTextImageGIF(
                              message: repliedText, type: repliedMessageType),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                      DisplayTextImageGIF(message: message, type: type),
                    ],
                  ),
                ),
                Positioned(
                  bottom: isSender ? 4 : 2,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        isSender
                            ? isSeen
                                ? Icons.done_all
                                : Icons.done
                            : Icons.done,
                        size: 20,
                        color: isSender
                            ? isSeen
                                ? Colors.blue
                                : Colors.white60
                            : Colors.white60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
