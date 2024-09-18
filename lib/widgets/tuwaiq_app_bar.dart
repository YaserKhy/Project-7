import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/screens/add_project/add_project_screen.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';

class TuwaiqAppBar extends StatelessWidget {
  final dynamic cubit;
  final String page;
  const TuwaiqAppBar({super.key, required this.page, required this.cubit});

  @override
  Widget build(BuildContext context) {
    ProfileModel user = GetIt.I.get<AuthLayer>().currentUser!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: context.getWidth(),
      height: page=='home' ? 190 : 160,
      decoration: const BoxDecoration(
        color: AppConstants.mainPurple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        )
      ),
      child: Column(
        children: [
          const SizedBox(height: 38),
          page == 'home' ? ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: ClipOval(
                child: cubit.handleLogo(
                  logoUrl: user.imageUrl,
                  context: context
                )
              )
            ),
            title: const Text("Welcome"),
            titleTextStyle: const TextStyle(
              inherit: false,
              fontFamily: "Lato",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xffdadada)
            ),
            subtitle: Text('${user.firstName} ${user.lastName}  👋'),
            subtitleTextStyle: const TextStyle(
              inherit: false,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              fontFamily: "Lato",
              color: Colors.white
            ),
          )
          : Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "My Projects",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Lato"
                      ),
                    ),
                    Text(user.role, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300, color: Colors.white54),)
                  ],
                ),
                user.role =='user' ? const SizedBox.shrink() : IconButton(
                  onPressed: () => context.push(screen: const AddProjectScreen()),
                  icon: const Icon(
                    Icons.add_box,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: context.getWidth(divideBy: 1.2),
                height: 30,
                child: TextFormField(
                  controller: page=='home' ? cubit.searchController : cubit.mySearchController,
                  onChanged: (value) => cubit.handleMySearch(value),
                  cursorHeight: 17,
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: page == 'home' ? "Search for a project ...." : "Search your projects ....",
                    hintStyle: const TextStyle(color: Colors.black45, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppConstants.mainPurple,
                        width: 1.5
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),
              const Icon(Icons.qr_code, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}