import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/widgets/cards/team_member.dart';

class ProjectScreen extends StatelessWidget {
  final HomeCubit cubit;
  final ProjectModel project;
  const ProjectScreen({super.key, required this.project, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.projectName), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: AppConstants.mainPurple, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: AppConstants.mainPurple,
                              offset: Offset(2, 4))
                        ]),
                    alignment: Alignment.center,
                    child: cubit.handleLogo(
                        logoUrl: project.logoUrl,
                        context: context,
                        heightDivide: 5,
                        widthDivide: 2),
                  ),
                ),
                const SizedBox(height: 41),
                Text(project.projectName,
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                Text(project.projectDescription,
                    style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 20),
                const Text("Presentation",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                Text(project.presentationUrl),
                const SizedBox(height: 20),
                const Text("Images",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                const SizedBox(height: 20),
                SizedBox(
                  height: context.getHeight(divideBy: 5),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: project.imagesProject.length,
                    itemBuilder: (context, index) {
                      return cubit.handleLogo(
                          logoUrl: project.imagesProject[index].url,
                          context: context,
                          heightDivide: 10,
                          widthDivide: 3);
                    }, separatorBuilder: (context, index)=>const SizedBox(width: 20,)),
                  ),
                const SizedBox(height: 20),
                const Text("Rating",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: AppConstants.mainPurple,
                            offset: Offset(2, 4))
                      ],
                      border: Border.all(
                          width: 1.5, color: AppConstants.mainPurple),
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 64,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BlocBuilder<HomeCubit, HomeState>(
                              bloc: cubit,
                              builder: (context, state) {
                                if (state is LoadingState) {
                                  return const CircularProgressIndicator();
                                }
                                if (state is ErrorState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.msg)));
                                }
                                if (state is ShowBottomSheetState) {
                                  return Container(
                                    width: context.getWidth(),
                                    height: context.getHeight(divideBy: 5),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Design",
                                            style: TextStyle(
                                                color: AppConstants.mainPurple,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 28)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        RatingStars(
                                          value: cubit.currentStars,
                                          onValueChanged: (value) =>
                                              cubit.changeStars(value),
                                          starCount: 10,
                                          starSize: 35,
                                          valueLabelVisibility: false,
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            );
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rate ${project.projectName}",
                          style: const TextStyle(
                              fontFamily: "Lato",
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        const Icon(Icons.arrow_forward_ios_outlined, size: 20)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Group Members",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                Column(
                  children: List.generate(project.membersProject.length, (index){
                    MembersProject member = project.membersProject[index];
                    return Column(
                      children: [
                        MemberCard(
                          member: member,
                          boxColor: member.id == project.userId ? AppConstants.orange : AppConstants.teamMember1,
                        ),
                        const SizedBox(height: 15,)
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 20),
                const Text("Links",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                SizedBox(
                  height: context.getHeight(divideBy: 17),
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: project.linksProject.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [BoxShadow(color: AppConstants.mainPurple, offset: Offset(2,4))],
                          border: Border.all(width: 1.5, color: AppConstants.mainPurple),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        // height: 50,
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cubit.getLinkIcon(project.linksProject[index].type),
                            const SizedBox(width: 5),
                            Text(project.linksProject[index].type)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppConstants.lightBlue),
                        child: const Icon(
                          Icons.edit,
                          size: 35,
                          color: AppConstants.blue,
                        ),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppConstants.lightRed),
                        child: const Icon(
                          Icons.delete_outline,
                          size: 35,
                          color: AppConstants.red,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
