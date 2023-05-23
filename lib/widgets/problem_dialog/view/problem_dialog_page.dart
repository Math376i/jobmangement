import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/widgets/problem_dialog/cubit/problem_dialog_cubit.dart';

class ProblemDialog extends StatelessWidget {
  const ProblemDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProblemDialogCubit(),
      child: const ProblemDialogView(),
    );
  }
}
