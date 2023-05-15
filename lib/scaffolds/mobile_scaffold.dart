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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: pages.asMap().entries.map((e) {
            return _buildNavigationItem(state, e.value, e.key);
          }).toList(),
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            const PopupMenuItem(
              value: SampleItem.itemOne,
              child: Text("Settings"),
            ),
          ],
        )
      ],
    );
  }

  NavigationItem _buildNavigationItem(AppState state, AppPage page, int index) {
    return NavigationItem(
      selected: state.selectedIndex == index,
      icon: page.icon,
      selectedIcon: page.selectedIcon,
      onPressed: () => state.selectedIndex = index,
    );
  }
}