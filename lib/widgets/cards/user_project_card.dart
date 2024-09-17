import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

import 'package:project7/extensions/screen_size.dart';

class UserProjectCard extends StatelessWidget {
  const UserProjectCard(
      {super.key,
      required this.name,
      required this.catgaory,
      required this.type,
      required this.date,
      required this.rate,
      required this.state});
  final String name;
  final String catgaory;
  final String type;
  final String date;
  final String rate;
  final String state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: AppConstants.mainPurple),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 115,
        child: Row(
          children: [
            const SizedBox(
              width: 70,
              height: 70,
              child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      //  user.projects.first.logoUrl
                      //         .contains('assets')
                      //     ? AssetImage(user.projects.first.logoUrl)
                      //     : Image.network(
                      //         user.projects.first.logoUrl,
                      //         errorBuilder:
                      //             (context, error, stackTrace) {
                      //           return Image.asset(
                      //               'assets/images/profile_holder.png');
                      //         },
                      //       ).image
                      AssetImage("assets/images/tuwaiq_logo1.png")),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.getWidth() / 1.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 15),
                          const SizedBox(width: 3),
                          Text(rate)
                        ],
                      )
                    ],
                  ),
                ),
                Text(
                  catgaory,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: context.getWidth() / 1.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xff4f27b3),
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Text(date)
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 59,
                        height: 18,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xff93F596)),
                        child: Text(
                          state,
                          style: TextStyle(fontSize: 10, fontFamily: "Lato"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
