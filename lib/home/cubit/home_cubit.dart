import 'package:bloc/bloc.dart';
import 'package:flutter_counter/app_state.dart';
import 'package:flutter_counter/jobapi_server.dart';
import 'package:flutter_counter/models.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoadingState());

  Future<void> getCriticalProblems() async {
    emit(HomeLoadingState());
    List<Problem> critProblems = await Server.getProblems();

    emit(HomeLoadedState(critProblems));
  }
}
