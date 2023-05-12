import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/home/cubit/home_cubit.dart';
import 'package:provider/provider.dart';

import 'package:flutter_counter/app_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //final state = Provider.of<HomeState>(context);
    //final homestate = Provider.of<HomeState>(context);
    final homeCubit = context.watch<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          BlocProvider.of<HomeCubit>(context).getCriticalProblems();
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeLoadedState) {
          return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.data[index].problemName),
                  subtitle: Text(state.data[index].description),
                );
              });
        } else {
          return const Center();
        }
      },
    );
  }

  _buildProblemContainer(HomeState state) {
    return Container(
      margin: EdgeInsets.all(15),
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              Text("Text"),
            ],
          ),
        ),
      ),
    );
  }
}
