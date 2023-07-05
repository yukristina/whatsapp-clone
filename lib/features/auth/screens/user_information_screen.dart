import 'package:flutter/material.dart';

class UserInformationScreen extends StatelessWidget {
  const UserInformationScreen({super.key});

  static const String routeName = 'user-information';

  final String networkImage = 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhY2h8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=400&q=60';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(networkImage),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
