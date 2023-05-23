import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/colors.dart';
import 'package:flutter_counter/home/cubit/home_cubit.dart';
import 'package:flutter_counter/models.dart';

class ProblemWidget extends StatelessWidget {
  final Problem problem;
  ProblemWidget(this.problem);

  @override
  Widget build(BuildContext context) {
    var color = ColorDef.company100;
    if (problem.status == "urgent") {
      color = ColorDef.allert;
    } else if (problem.status == "important") {
      color = ColorDef.warning;
    } else if (problem.status == "completed") {
      color = ColorDef.okay;
    }

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: ColorDef.company100,
      ),
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      padding: const EdgeInsets.all(8),
      child: ExpandablePanel(
        header: Row(
          children: [
            Text(
              '${problem.problemName} ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorDef.company700,
                  fontSize: 20,
                  decoration: TextDecoration.underline),
            ),
            Icon(
              Icons.circle,
              color: color,
            )
          ],
        ),
        collapsed: Row(
          children: [
            Text(problem.status),
          ],
        ),
        expanded: Container(
          child: Column(
            children: [
              Text("Description :${problem.description}"),
              Text("Location :${problem.latitude} ${problem.longitude}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeCubit>(context)
                            .changeToCompleted(problem.problemId);
                      },
                      child: const Text(
                        "Completed",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {}
}
