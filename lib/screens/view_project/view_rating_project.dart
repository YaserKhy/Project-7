import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/view_project_title.dart';
import 'package:project7/widgets/cards/rating_project.dart';
import 'package:project7/widgets/icons/project_icon.dart';

class ViewRatingProject extends StatelessWidget {
  final ProjectModel project;
  final HomeCubit cubit;
  const ViewRatingProject({super.key, required this.project, required this.cubit});
  
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //project.projectName,
                                    Text(project.projectName,
                                        style: const TextStyle(
                                            color: AppConstants.mainPurple,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ProjectIcon(
                                        icon: const Icon(
                                          Icons.lightbulb,
                                          color: Color(0xffff8c2c),
                                          size: 18,
                                        ),
                                        title: project.bootcampName,
                                        isVertical: true),
                                    ProjectIcon(
                                        icon: const Icon(
                                          Icons.code,
                                          color: Color(0xff01e6d5),
                                          size: 18,
                                        ),
                                        title: project.type,
                                        isVertical: true),
                                    ProjectIcon(
                                        icon: const Icon(
                                          Icons.calendar_month_rounded,
                                          color: Color(0xff4f27b3),
                                          size: 18,
                                        ),
                                        title: "${project.endDate.substring(2, 4)}/${project.endDate.substring(5, 7)}",
                                        isVertical: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          const ViewProjectTitle(title: 'Rating', editable:false),
                          const Text(
                            "Support this group and give them your feedback on scale 1 to 10 how do you rate ",
                            style: TextStyle(
                                color: AppConstants.textGrayColor,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RatingField(
                            cubit: cubit, title: 'Idea', iconToAdd: const Icon(Icons.lightbulb, color: AppConstants.orange,)),
                          const SizedBox(
                            height: 20,
                          ),
                          RatingField(
                            cubit: cubit, 
                            title: "Design",
                            iconToAdd: const Icon(
                              Icons.color_lens_outlined,
                              color: Color(0xffF565BB),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RatingField(
                            cubit: cubit, 
                              title: "Tools",
                              iconToAdd: const Icon(
                                Icons.keyboard_command_key_sharp,
                                color: AppConstants.brownIcon,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          RatingField(
                            cubit: cubit, 
                              title: "Practices",
                              iconToAdd: const Icon(
                                Icons.shape_line_outlined,
                                color: AppConstants.blue,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          RatingField(
                            cubit: cubit, 
                              title: "Presentation",
                              iconToAdd: const Icon(
                                Icons.screenshot_monitor_outlined,
                                color: Color(0xffff8c2c),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          RatingField(
                            cubit: cubit, 
                            
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
                                    controller: cubit.commentController,
                                    maxLines: null, // Expands vertically as needed
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 133,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Square shape (no rounded corners)
                                          side: const BorderSide(
                                              color: Colors.green,
                                              width: 2), // Blue border
                                        )),
                                    child: const Text("Save")),
                              ),
                              SizedBox(
                                width: 133,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Square shape (no rounded corners)
                                          side: const BorderSide(
                                              color:
                                                  AppConstants.iconsGrayColor,
                                              width: 2), // Blue border
                                        )),
                                    child: const Text("Cancel")),
                              ),
                            ],
                          )
                        ])))));
  }
}
