part of 'home_cubit.dart';

@immutable
abstract class HomeState extends AppState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Problem> data;

  HomeLoadedState(this.data);
}
