import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/view_member_links.dart';

class ViewProjectMember extends StatelessWidget {
  final MembersProject member;
  final String teamLeadId;
  final HomeCubit cubit;
  const ViewProjectMember({super.key, required this.member, required this.teamLeadId, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    Color borderColor = member.id == teamLeadId ? const Color(0xff57e3d8) : const Color(0xfff4a664);
    return Column(
      children: [
        Container(
          width: context.getWidth(),
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black45, width: 1)),
                child: ClipOval(child: shared.handleLogo(context: context, logoUrl: member.imageUrl, widthDivide: 10))
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.getWidth(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${member.firstName} ${member.lastName}',
                            style: const TextStyle(fontFamily: "Lato",fontSize: 16,fontWeight: FontWeight.w500)
                          ),
                          ViewMemberLinks(links: member.link)
                        ]
                      ),
                    ),
                    Text(
                      member.id == teamLeadId ? 'Team Lead' : 'Team Member',
                      style: const TextStyle(color: Color(0xff474747),fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "Lato")
                    ),
                    Text(
                      member.position,
                      style: const TextStyle(color: Color(0xff474747),fontSize: 10,fontWeight: FontWeight.w500,fontFamily: "Lato")
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15)
      ],
    );
  }
}