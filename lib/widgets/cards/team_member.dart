import 'package:flutter/material.dart';
import 'package:project7/models/project_model.dart';

class MemberCard extends StatelessWidget {
  const MemberCard(
      {super.key,
      required this.member,
      required this.boxColor,});

  final MembersProject member;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: boxColor,
            offset: const Offset(2, 4),
          ),
        ],
        border: Border.all(width: 1.5, color: boxColor),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 64,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: member.imageUrl.contains('assets') ? AssetImage(member.imageUrl)
            : Image.network(member.imageUrl, errorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/profile_holder.png');
            },).image
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the left
            children: [
              Text(
                '${member.firstName} ${member.lastName}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                member.position,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
