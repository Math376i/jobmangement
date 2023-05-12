import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'mobile_scaffold.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    //var responsive = ResponsiveWrapper.of(context);
    return const MobileScaffold();
  }
}
