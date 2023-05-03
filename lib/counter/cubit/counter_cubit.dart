import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(PageInitial());

  Future<void> loadData() async {
    emit(PageLoading());

    //Loading Data
    var data = 1;
    emit(PageLoaded(data));
  }

  void setError(error) {
    emit(PageError(error));
  }
}
