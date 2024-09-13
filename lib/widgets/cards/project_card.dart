import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:project7/extensions/screen_size.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: const Color(0xff4931af)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Color(0xff4931af), offset: Offset(2, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.asset(
              'assets/images/tuwaiq_logo1.png',
              width: context.getWidth(),
              height: context.getHeight(divideBy: 10),
              fit: BoxFit.cover,
            )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Project name",
              style: TextStyle(
                  fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingStars(
                  starCount: 5,
                  starSize: 20,
                  valueLabelVisibility: false,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_2_outlined,
                      size: 20,
                    ),
                    Text("4")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
