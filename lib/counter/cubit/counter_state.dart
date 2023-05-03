part of "counter_cubit.dart";

@immutable
abstract class CounterState {}

class PageInitial extends CounterState {
  final message = "initial-d";
}

class PageLoading extends CounterState {}

class PageLoaded extends CounterState {
  final int count;

  PageLoaded(this.count);
}

class PageError extends CounterState {
  final error;

  PageError(this.error);
}
