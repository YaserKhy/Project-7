import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';

part 'view_project_state.dart';

class ViewProjectCubit extends Cubit<ViewProjectState> {
  ViewProjectCubit() : super(ViewProjectInitial());
  final api = NetworkingApi();
  String stateNow = "";
  String canRate = "";
  String canEdit = "";
  TextEditingController commentController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  addMember({required String projectId, required List<MembersProject> currentMembers}) async {
    try {
      emit(LoadingState());
      List<Map<String,dynamic>> total = [];
      for (var member in currentMembers) {
        total.add({'position' : member.position, 'user_id': member.id});
      }
      total.add({'position' : positionController.text, 'user_id': userIdController.text});
      await api.addMember(projectId:projectId,newData: total);
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown Error"));
    }
  }

  Map<String, dynamic> rating = {
    "idea":0.0,
    "design":0.0,
    "tools":0.0,
    "practices":0.0,
    "presentation":0.0,
    "investment":0.0,
    "note": ""
  };

  showStars() {
    emit(ShowStarsState());
  }

  changeStars(String field,double newStars) {
    log('$field rating is ${(newStars*2).toInt()}');
    rating[field] = newStars;
    emit(StarChangedState(field: field, newStars:newStars));
  }

  submitRating({required String projectId}) async {
    rating['idea'] = (rating['idea']*2).toInt();
    rating['design'] = (rating['design']*2).toInt();
    rating['tools'] = (rating['tools']*2).toInt();
    rating['practices'] = (rating['practices']*2).toInt();
    rating['presentation'] = (rating['presentation']*2).toInt();
    rating['investment'] = (rating['investment']*2).toInt();
    rating['note'] = commentController.text;
    try {
      emit(LoadingState());
      await api.submitRating(ratingData: rating, projectId: projectId, token: GetIt.I.get<AuthLayer>().auth!.token);
      emit(ShowStarsState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown Error"));
    }
  }

  editProjectSettings({required String projectId, required String endDate}) async {
    try {
      emit(LoadingState());
      await api.editProjectStatus(
          token: GetIt.I.get<AuthLayer>().auth!.token,
          projectId: projectId,
          endDate: endDate,
          isEditable: canEdit == "Allow Team Lead to Edit" ? true : false,
          isRatable: canRate == "Allow Rating" ? true : false,
          isPublic: stateNow == "Public" ? true : false);
      canEdit = "";
      canRate = "";
      stateNow = "";
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown Error"));
    }
  }

  String currentState({required ProjectModel project}) {
    stateNow = project.isPublic ? "Public" : "Private";
    return stateNow;
  }

  setCurrentState({required String value}) {
    stateNow = value;
    log(stateNow);
    emit(UpdateRadioButtonState(status: stateNow));
  }

  String currentRatingState({required ProjectModel project}) {
    canRate = project.allowRating ? "Allow Rating" : "Do Not Allow Rating";
    return canRate;
  }

  setCurrentRatingState({required String value}) {
    canRate = value;
    log(canRate);
    emit(UpdateRadioButtonRating(rating: canRate));
  }

  String currentEditingState({required ProjectModel project}) {
    canEdit = project.allowEdit
        ? "Allow Team Lead to Edit"
        : "Do Not Allow Team Lead to Edit";
    return canEdit;
  }

  setCurrentEditingState({required String value}) {
    canEdit = value;
    log(canEdit);
    emit(UpdateRadioButtonEditing(editing: canEdit));
  }

  deleteProject({required String projectId}) async {
    try {
      emit(LoadingState());
      await api.deleteProject(
          projectId: projectId, token: GetIt.I.get<AuthLayer>().auth!.token);
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown Error"));
    }
  }

  updateLogo({required String projectId, required String logoUrl}) async {
    try {
      emit(LoadingState());
      await api.editProjectLogo(
          token: GetIt.I.get<AuthLayer>().auth!.token,
          projectId: projectId,
          imgPath: logoUrl);
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: error.toString()));
    }
  }

  updateImages(
      {required List<String> imgs,
      required String projectId,
      required List<ImagesProject> projectImages}) async {
    try {
      emit(LoadingState());
      await api.editProjectImages(
          token: GetIt.I.get<AuthLayer>().auth!.token,
          projectId: projectId,
          imgsPaths: imgs,
          currentImages: projectImages
        );
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown error"));
    }
  }

  deleteImage({required String projectId, required List<ImagesProject> projectImages, required ImagesProject imgToDelete}) async {
    try {
      emit(LoadingState());
      await api.deleteProjectImage(
        token: GetIt.I.get<AuthLayer>().auth!.token,
        projectId: projectId,
        imgToDelete: imgToDelete,
        images: projectImages
      );
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown error"));
    }
  }

  updatePresentation({
    required String projectId,
    required String presentationPath,
  }) async {
    try {
      emit(LoadingState());
      await api.editProjectPresentation(
        token: GetIt.I.get<AuthLayer>().auth!.token,
        projectId: projectId,
        presentationPath: presentationPath
      );
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown error"));
    }
  }
}
