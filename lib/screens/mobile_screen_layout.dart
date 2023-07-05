import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';
import 'package:whatsapp_clone/widgets/contacts_list.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
    // DefaultTabController(
    //   length: 3,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: appBarColor,
    //       elevation: 0,
    //       centerTitle: false,
    //       title: const Text('Whatsapp Clone',
    //           style: TextStyle(
    //               color: Colors.grey,
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold)),
    //       actions: [
    //         IconButton(
    //           onPressed: () {},
    //           icon: const Icon(
    //             Icons.search,
    //             color: Colors.grey,
    //           ),
    //         ),
    //         IconButton(
    //           onPressed: () {},
    //           icon: const Icon(
    //             Icons.more_vert,
    //             color: Colors.grey,
    //           ),
    //         ),
    //       ],
    //       bottom: const TabBar(
    //           indicatorColor: tabColor,
    //           indicatorWeight: 4,
    //           labelColor: tabColor,
    //           unselectedLabelColor: Colors.grey,
    //           labelStyle: TextStyle(fontWeight: FontWeight.bold),
    //           tabs: [
    //             Tab(
    //               text: 'CHATS',
    //             ),
    //             Tab(
    //               text: 'STATUS',
    //             ),
    //             Tab(
    //               text: 'CALLS',
    //             ),
    //           ]),
    //     ),
    //     body: const ContactsList(),
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () {},
    //       backgroundColor: tabColor,
    //       child: const Icon(
    //         Icons.comment,
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );
  }
}
