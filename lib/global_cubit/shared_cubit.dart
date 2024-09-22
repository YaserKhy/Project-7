import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';
part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(SharedInitial());
  final api = NetworkingApi();

  // may be needed because of the delay of loading appbar after the projects
  // getData(String? token) {
  //   getProfile(token);
  //   // getAllProjects
  // }

  updateProfile() {
    emit(ShowProfileState(profile: GetIt.I.get<AuthLayer>().currentUser));
  }

  bool isUser () {
    return GetIt.I.get<AuthLayer>().currentUser!.role == 'user';
  }

  bool canEdit({required ProjectModel project}) {
    // either admin/supervisor or authorized team lead

    // if admin or supervisor
    if(GetIt.I.get<AuthLayer>().currentUser!.id == project.adminId) {
      return true;
    }

    // if authorized team lead 
    if(GetIt.I.get<AuthLayer>().currentUser!.id == project.userId && project.allowEdit==true) {
      return true;
    }
    return false;
  }

  getProfile(String? token) async {
    if(token==null) { return; }
    try {
      emit(LoadingState());
      log("pro1");
      GetIt.I.get<AuthLayer>().currentUser = await api.getProfile(token:token);
      GetIt.I.get<AuthLayer>().box.write('currentUser', GetIt.I.get<AuthLayer>().currentUser);
      emit(ShowProfileState(profile: GetIt.I.get<AuthLayer>().currentUser));
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is error with code 194FR94"));
    }
  }

  editProfile({
    required String token,
    required String firstName,
    required String lastName,
    required String? imagePath,
    required String? cvPath,
    required String bindLink,
    required String github,
    required String linkedIn,
  }) async {
    emit(LoadingState());
    await api.editProfile(
        token: token,
        firstName: firstName,
        bindlink: bindLink,
        cvPath: cvPath,
        github: github,
        imagePath: imagePath,
        lastName: lastName,
        linkedin: linkedIn);
    await getProfile(token);
  }

  handleProfilePage({required String? logoUrl, required BuildContext context}) {
    Widget placeholderAvatar = Image.asset('assets/images/tuwaiq_logo1.png',
        width: context.getWidth(),
        height: context.getHeight(divideBy: 10),
        fit: BoxFit.cover);
    return logoUrl!.contains('assets')
        ? placeholderAvatar
        : Image.network(logoUrl,
            width: 89,
            height: 89,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => placeholderAvatar);
  }

  Widget handleLogo(
      {required String logoUrl,
      required BuildContext context,
      bool? isRounded,
      double? heightDivide,
      double? height,
      double? widthDivide}) {
    Image placeholderLogo = Image.asset('assets/images/tuwaiq_logo1.png',
        width: height!=null ? null : context.getWidth(divideBy: widthDivide ?? 2),
        height: height ?? context.getHeight(divideBy: heightDivide ?? 10),
        fit: BoxFit.cover);
    return logoUrl.contains('assets')
        ? placeholderLogo
        : Container(
          decoration: BoxDecoration(color: AppConstants.mainPurple, borderRadius: BorderRadius.circular(20)),
          child: Image.network(logoUrl,
              width: context.getWidth(divideBy: widthDivide ?? 1),
              height: context.getHeight(divideBy: heightDivide ?? 10),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => placeholderLogo),
        );
  }
}
