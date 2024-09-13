import 'package:flutter/material.dart';
import 'package:project7/widgets/cards/account_card.dart';
import 'package:project7/widgets/cards/profile_card.dart';
import 'package:project7/widgets/custom_icons_icons.dart';
import 'package:project7/widgets/texts/profile_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CustomIcons.edit,
                color: Color(0xff4D2EB4),
              ))
        ],
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileCard(
            profileImg: "assets/images/profile_holder.png",
            name: "Rahaf Alghamdi",
            role: "user",
            email: "xalap95777@orsbap.com",
            id: "0a164eaf-8f34-4fea-9a00-443f1eb05bd9",
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Divider(),
          ),
          ProfileTitle(title: "Accounts"),
          SizedBox(height: 22),
          AccountCard(
              icon: Icon(Icons.description_outlined, size: 40),
              title: "Resume"),
          AccountCard(
              icon: Icon(CustomIcons.linkedin_in, size: 40), title: "Resume"),
          AccountCard(
              icon: Icon(CustomIcons.github, size: 40), title: "Resume"),
          AccountCard(title: "Bindlink")
        ],
      ),
    );
  }
}
