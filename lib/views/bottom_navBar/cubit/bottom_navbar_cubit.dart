import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navbar_state.dart';

class BottomNavbarCubit extends Cubit<BottomNavbarState> {
  BottomNavbarCubit() : super(const BottomNavbarState());

  void goToSection(index){
    emit(state.copyWith(index:index ));
  }
}
