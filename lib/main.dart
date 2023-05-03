import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app_state.dart';
import 'scaffolds/app_scaffold.dart';
import 'scroll_wrapper.dart';

void main() {
  runApp(JobManagementApp());
}

class JobManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveWrapper.builder(
          StretchingScrollWrapper.builder(context, child!),
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(500, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(600, name: TABLET)
          ],
        ),
        home: const AppScaffold(),
      ),
    );
  }
}
