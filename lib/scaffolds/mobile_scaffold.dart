import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../pages.dart';
import '../widgets/navigation_item.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return Scaffold(
      body: state.currentPage.builder(),
      bottomNavigationBar: _buildNavigationBar(state),
    );
  }

  _buildNavigationBar(AppState state) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: pages.asMap().entries.map((e) {
                return _buildNavigationItem(state, e.value, e.key);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  NavigationItem _buildNavigationItem(AppState state, AppPage page, int index) {
    return NavigationItem(
      text: "Hello",
      selected: state.selectedIndex == index,
      icon: page.icon,
      selectedIcon: page.selectedIcon,
      onPressed: () => state.selectedIndex = index,
    );
  }
}
