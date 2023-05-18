import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/home/cubit/home_cubit.dart';
import 'package:flutter_counter/home/widgets/problem_form_widget.dart';
import 'package:flutter_counter/home/widgets/problem_widget.dart';
import 'package:provider/provider.dart';

import 'package:flutter_counter/app_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //final state = Provider.of<HomeState>(context);
    //final homestate = Provider.of<HomeState>(context);
    //final homeCubit = context.watch<HomeCubit>();
    final TextEditingController _textEditingController =
        TextEditingController();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          BlocProvider.of<HomeCubit>(context).getCriticalProblems();
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeLoadedState) {
          return Scaffold(
            body: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return ProblemWidget(state.data[index]);
                }),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: FloatingActionButton(
                    onPressed: () =>
                        BlocProvider.of<HomeCubit>(context).refresh(),
                    tooltip: 'Refresh Page',
                    child: const Icon(Icons.refresh_outlined),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: FloatingActionButton(
                    onPressed: () => BlocProvider.of<HomeCubit>(context)
                        .createNewProblemModal(),
                    tooltip: 'Create new Problem',
                    child: const Icon(Icons.new_label_outlined),
                  ),
                )
              ],
            ),
          );
        } else if (state is HomeNewProblemModalState) {
          return Scaffold(
            appBar: AppBar(actions: [
              BackButton(
                onPressed: () =>
                    BlocProvider.of<HomeCubit>(context).backToMain(),
              )
            ]),
            body: ProblemFormWidget(),
          );
        } else {
          return const Center();
        }
      },
    );
  }

  void onChanged(bool? value) {}
}
