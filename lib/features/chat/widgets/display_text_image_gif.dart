import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DisplayTextImageGIF extends StatelessWidget {
  const DisplayTextImageGIF(
      {super.key, required this.message, required this.type});

  final String message;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : CachedNetworkImage(imageUrl: message);
  }
}
