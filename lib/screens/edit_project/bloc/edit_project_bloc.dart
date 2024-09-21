import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/networking/networking_api.dart';
part 'edit_project_event.dart';
part 'edit_project_state.dart';

class EditProjectBloc extends Bloc<EditProjectEvent, EditProjectState> {
  final api = NetworkingApi();
  EditProjectBloc() : super(EditProjectInitial()) {
    on<EditBaseInfoEvent>(editBaseInfo);
  }

  Future<void> editBaseInfo(EditBaseInfoEvent event, Emitter<EditProjectState> emit) async {
    try {
      emit(LoadingState());
      await api.editProjectBaseInfo(
        token: event.token,
        id: event.id,
        name: event.name,
        bootcamp: event.bootcamp,
        description: event.description,
        endDate: event.endDate,
        presentationDate: event.presentationDate,
        startDate: event.startDate,
        type: event.type
      );
      GetIt.I.get<AuthLayer>().currentUser = await api.getProfile(token: event.token);
      GetIt.I.get<AuthLayer>().box.write('currentUser', GetIt.I.get<AuthLayer>().currentUser);
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is unknown error"));
    }
  }
}