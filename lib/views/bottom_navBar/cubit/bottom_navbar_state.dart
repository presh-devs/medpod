part of 'bottom_navbar_cubit.dart';

@immutable
 class BottomNavbarState {
final int index;

  const BottomNavbarState({this.index = 0});

  BottomNavbarState copyWith({final int? index}){
    return BottomNavbarState(index: index ?? this.index);
  }

 }


