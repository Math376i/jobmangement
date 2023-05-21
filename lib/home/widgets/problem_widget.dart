import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/models.dart';

class ProblemWidget extends StatelessWidget {
  final Problem problem;
  ProblemWidget(this.problem);

  @override
  Widget build(BuildContext context) {
    var color = Colors.blue;
    if (problem.status == "urgent") {
      color = Colors.amber;
    } else if (problem.status == "important") {
      color = Colors.red;
    }

    return Container(
      color: color,
      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      padding: EdgeInsets.all(8),
      child: ExpandablePanel(
        header: Text(problem.problemName),
        collapsed: Text(problem.status),
        expanded: Container(
          child: Column(
            children: [
              Text("Description :${problem.description}"),
              Text("Location :${problem.latitude} ${problem.longitude}"),
            ],
          ),
        ),
      ),
    );
  }
}
