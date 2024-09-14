import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  const MemberCard(
      {super.key,
      required this.name,
      required this.role,
      required this.boxColor,
      required this.shadowColor});

  final String name;
  final String role;
  final Color boxColor;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(2, 4),
          ),
        ],
        border: Border.all(width: 1.5, color: boxColor),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 64,
      child: Row(
        children: [
          Icon(
            Icons.account_circle_outlined,
            size: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the left
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                role,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
