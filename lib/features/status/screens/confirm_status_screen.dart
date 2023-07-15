import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/status/controller/status_controller.dart';

class ConfirmStatusScreen extends ConsumerWidget {
  const ConfirmStatusScreen({required this.file, super.key});
  final File file;

  static const String routeName = 'confirm-status';

  void addStatus(WidgetRef ref, BuildContext context) {
    ref.read(statusControllerProvider).addStatus(file, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.file(file),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addStatus(ref, context),
        backgroundColor: tabColor,
        child: const Icon(
          Icons.done,
          color: whiteColor,
        ),
      ),
    );
  }
}
