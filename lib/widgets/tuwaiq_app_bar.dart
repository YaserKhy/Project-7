import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/global_cubit/shared_cubit.dart' as shared;
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/my_projects/cubit/my_projects_cubit.dart';
import 'package:project7/widgets/cards/home_profile_card.dart';

class TuwaiqAppBar extends StatelessWidget {
  final HomeCubit homeCubit;
  final MyProjectsCubit myProjectsCubit;
  final String page;
  final Function()? onAdd;
  const TuwaiqAppBar({super.key, required this.page, required this.homeCubit, required this.myProjectsCubit, this.onAdd});

  @override
  Widget build(BuildContext context) {
    // main style of the appbar
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: context.getWidth(),
      height: page == 'home' ? 190 : 160,
      decoration: const BoxDecoration(
        color: AppConstants.mainPurple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        )
      ),
      // content of app bar depending on current page
      child: Column(
        children: [
          const SizedBox(height: 38),
          page == 'home' ? BlocBuilder<shared.SharedCubit, shared.SharedState>(
            builder: (context, state) {
              if(state is shared.ShowProfileState) {
                return HomeProfileCard(profile: state.profile);
              }
              if(state is shared.LoadingState) {
                return const HomeProfileCard();
              }
              return const SizedBox(height: 50,);
            },
          )
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "My Projects",
                      style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: "Lato"),
                    ),
                    // <<<<<<<<<<<<<< TO BE DISCUSSED NOTICE >>>>>>>>>>>>>>>>>
                    Text(
                      GetIt.I.get<AuthLayer>().currentUser!.role,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                        color: Colors.white
                      ),
                    )
                  ],
                ),
                GetIt.I.get<AuthLayer>().currentUser!.role == 'user' ? const SizedBox.shrink()
                : IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_box,size: 35,color: Colors.white,),
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
                  controller: page == 'home' ? homeCubit.searchController : myProjectsCubit.mySearchController,
                  onChanged: (value) => page == 'home' ? homeCubit.handleSearch(value) : myProjectsCubit.handleMySearch(value),
                  cursorHeight: 17,
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: page == 'home' ? "Search for a project ...." : "Search your projects ....",
                    hintStyle: const TextStyle(color: Colors.black45, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppConstants.mainPurple, width: 1.5),
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