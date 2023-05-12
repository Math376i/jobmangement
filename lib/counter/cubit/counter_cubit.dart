import 'package:bloc/bloc.dart';
import 'package:flutter_counter/jobapi_server.dart';
import 'package:flutter_counter/models.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(PageInitial());

  Future<void> loadData() async {
    emit(PageLoading());

    await Future.delayed(Duration.zero);

    List<Problem> problems = await Server.getProblems();
    int testdata = problems[1].problemId;

    print("refresh done");
    //Loading Data
    var data = 1;
    emit(PageLoaded(testdata));
  }

  void setError(error) {
    emit(PageError(error));
  }
}
