import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/view_project/view_project_title.dart';
import 'package:project7/widgets/cards/rating_project.dart';
import 'package:project7/widgets/icons/project_icon.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ViewRatingProject extends StatelessWidget {
  // late final ProjectModel project;
  // ViewRatingProject({required this.project});
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.bgColor,
        appBar: AppBar(
          backgroundColor: AppConstants.bgColor,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 111.82,
                                  height: 111.82,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: .5,
                                          color: const Color(0xff4f27b3))),
                                  child: ClipOval(
                                      child: Image.asset(
                                          'assets/images/tuwaiq_logo1.png')),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    //project.projectName,
                                    Text("Test Project",
                                        style: TextStyle(
                                            color: AppConstants.mainPurple,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ProjectIcon(
                                        icon: Icon(
                                          Icons.lightbulb,
                                          color: Color(0xffff8c2c),
                                          size: 18,
                                        ),
                                        //project.projectName,
                                        title: "Flutter",
                                        isVertical: true),
                                    ProjectIcon(
                                        icon: Icon(
                                          Icons.code,
                                          color: Color(0xff01e6d5),
                                          size: 18,
                                        ),
                                        //project.type
                                        title: "App",
                                        isVertical: true),
                                    ProjectIcon(
                                        icon: Icon(
                                          Icons.calendar_month_rounded,
                                          color: Color(0xff4f27b3),
                                          size: 18,
                                        ),
                                        title: "17/09",
                                        // "${project.endDate.substring(2, 4)}/${project.endDate.substring(5, 7)}",
                                        isVertical: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          // const ViewProjectTitle(title: 'Rating'),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Text("Rating",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w400,
                                          color: AppConstants.mainPurple)),
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                          const Text(
                            "Support this group and give them your feedback on scale 1 to 10 how do you rate ",
                            style: TextStyle(
                                color: AppConstants.textGrayColor,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.lightbulb,
                                color: AppConstants.orange,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Idea",
                                    style: TextStyle(
                                        color: AppConstants.mainPurple,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.black,
                                        size: 15,
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const RatingField(
                            title: "Design",
                            iconToAdd: Icon(
                              Icons.color_lens_outlined,
                              color: Color(0xffF565BB),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const RatingField(
                              title: "Tools",
                              iconToAdd: const Icon(
                                Icons.keyboard_command_key_sharp,
                                color: AppConstants.brownIcon,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const RatingField(
                              title: "Practices",
                              iconToAdd: const Icon(
                                Icons.shape_line_outlined,
                                color: AppConstants.blue,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const RatingField(
                              title: "Presentation",
                              iconToAdd: const Icon(
                                Icons.screenshot_monitor_outlined,
                                color: Color(0xffff8c2c),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const RatingField(
                              title: "Investment",
                              iconToAdd: const Icon(
                                Icons.attach_money_sharp,
                                color: Colors.green,
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text("Note"),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  color: Colors.white,
                                  width: 353,
                                  height: 115,
                                  child: TextField(
                                    controller: commentController,
                                    maxLines:
                                        null, // Expands vertically as needed

                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 133,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Save"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Square shape (no rounded corners)
                                          side: const BorderSide(
                                              color: Colors.green,
                                              width: 2), // Blue border
                                        ))),
                              ),
                              SizedBox(
                                width: 133,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Cansel"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Square shape (no rounded corners)
                                          side: const BorderSide(
                                              color:
                                                  AppConstants.iconsGrayColor,
                                              width: 2), // Blue border
                                        ))),
                              ),
                            ],
                          )
                        ])))));
  }
}
