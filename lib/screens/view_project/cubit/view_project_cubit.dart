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
  // TextEditingController commentController = TextEditingController();

  // ViewProjectCubit() : super("Private"); // Initial state is "Private"

  // void selectItem(String item) {
  //   emit(item);
  // }

  deleteProject({required String projectId}) async {
    try {
      emit(LoadingState());
      await api.deleteProject(
        projectId: projectId,
        token: GetIt.I.get<AuthLayer>().auth!.token
      );
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
        imgPath: logoUrl
      );
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown error"));
    }
  }

  updateImages({required List<String> imgs, required String projectId, required List<ImagesProject> projectImages}) async {
    // should append projectImages, currently : it overrides
    try {
      emit(LoadingState());
      await api.editProjectImages(
        token: GetIt.I.get<AuthLayer>().auth!.token,
        projectId: projectId,
        imgsPaths: imgs
      );
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown error"));
    }
  }
}