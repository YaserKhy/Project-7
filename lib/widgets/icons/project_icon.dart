import 'package:flutter/material.dart';

class ProjectIcon extends StatelessWidget {
  final String title;
  final Icon icon;
  final bool isVertical;
  const ProjectIcon(
      {super.key,
      required this.title,
      required this.icon,
      required this.isVertical});

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Column(
            children: [
              Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          offset: const Offset(0, 2),
                          blurRadius: 4)
                    ]),
                child: icon,
              ),
              const SizedBox(
                height: 9,
              ),
              SizedBox(
                  height: 100,
                  width: 120,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6d6d6d)),
                  ))
            ],
          )
        : Row(
            children: [
              Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          offset: const Offset(0, 2),
                          blurRadius: 4)
                    ]),
                child: icon,
              ),
              const SizedBox(
                width: 14,
              ),
              Text(title)
            ],
          );
  }
}
