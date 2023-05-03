import 'package:flutter/material.dart';

class StretchingScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

class StretchingScrollWrapper extends StatelessWidget {
  final Widget child;

  const StretchingScrollWrapper({Key? key, required this.child})
      : super(key: key);

  static Widget builder(BuildContext context, Widget child) {
    return StretchingScrollWrapper(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: StretchingScrollBehavior(),
      child: child,
    );
  }
}
