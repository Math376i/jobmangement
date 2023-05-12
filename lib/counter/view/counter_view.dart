import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/counter/cubit/counter_cubit.dart';

import 'package:flutter_counter/jobapi_server.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          if (state is PageInitial) {
            BlocProvider.of<CounterCubit>(context).loadData();
            return Center(
              child: Text(state.message),
            );
          } else if (state is PageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PageLoaded) {
            return Center(
              child: Text('Data: ${state.count}'),
            );
          } else if (state is PageError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            // This state should never be reached
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<CounterCubit>(context).loadData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
