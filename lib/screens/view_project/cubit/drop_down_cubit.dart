import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'drop_down_state.dart';


class DropdownCubit extends Cubit<String> {
  DropdownCubit() : super("Private"); // Initial state is "Private"

  void selectItem(String item) {
    emit(item);
  }
}
