import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/networking/networking_api.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final api = NetworkingApi();
  ProfileCubit() : super(ProfileInitial());

  getProfile({required String token}) async {
    try {
      emit(LoadingState());
      log("pro1");
      ProfileModel profileModel = await api.getProfile(token: token);
      log("pro2");

      emit(ShowProfileState(profile: profileModel));
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is error with code 194FR94"));
    }
  }

  handleProfilePage({required String logoUrl, required BuildContext context}) {
    Widget placeholderAvatar = Image.asset('assets/images/profile_holder.png',
        width: context.getWidth(),
        height: context.getHeight(divideBy: 10),
        fit: BoxFit.cover);
    return logoUrl.contains('assets')
        ? placeholderAvatar
        : Image.network(logoUrl,
            width: 89,
            height: 89,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => placeholderAvatar);
  }

  logOut() {
    GetIt.I.get<AuthLayer>().logOut();
  }

  editProfile({required ProfileModel profileModel}) async {
    api.editProfile(profile: profileModel);
  }
}
