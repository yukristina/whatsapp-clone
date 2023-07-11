import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp_clone/models/chat_contact.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: StreamBuilder<List<ChatContact>>(
          stream: ,
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: info.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MobileChatScreen(
                                  name: 'Jisoo',
                                  uid: '12345',
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            info[index]['name'].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              info[index]['message'].toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              info[index]['profilePic'].toString(),
                            ),
                            radius: 30,
                          ),
                          trailing: Text(
                            info[index]['time'].toString(),
                            style:
                                const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: dividerColor,
                      indent: 85,
                    )
                  ],
                );
              });
          },
      
        ),);
  }
}



// i've used listview separeater instead of put listview builder in column
