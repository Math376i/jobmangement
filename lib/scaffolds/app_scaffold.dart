import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'mobile_scaffold.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MobileScaffold();
  }
}
