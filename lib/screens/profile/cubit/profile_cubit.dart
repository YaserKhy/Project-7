import 'dart:developer';
import 'dart:typed_data';

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
    Widget placeholderAvatar = Image.asset('assets/images/tuwaiq_logo1.png',
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

  editProfile({
    required String token,
    required String firstName,
    required String lastName,
    required Future<Uint8List> image,
    required Future<Uint8List> cv,
    required String bindLink,
    required String github,
    required String linkedIn,
  }) async {
    await api.editProfile(
        token: token,
        firstName: firstName,
        bindlink: bindLink,
        cv: cv,
        github: github,
        image: image,
        lastName: lastName,
        linkedin: linkedIn);
  }
}
