import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/settings/cubit/settings_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            BlocProvider.of<SettingsCubit>(context).loadSettings();
            return const Center(
              child: Text("Initial State Dummy"),
            );
          }
          if (state is SettingsLoaded) {
            return const Center(
              child: Text("Loaded"),
            );
          }
          return const Center(
            child: Text("Settings Page"),
          );
        },
      ),
    );
  }
}
