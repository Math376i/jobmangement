import 'package:flutter/material.dart';
import 'package:flutter_counter/home/cubit/home_cubit.dart';
import 'package:provider/provider.dart';

import 'package:flutter_counter/app_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    //final homestate = Provider.of<HomeState>(context);

    return Scaffold(
        body: Center(
      child: Text("Hello Home"),
    ));
  }
}
