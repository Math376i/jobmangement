import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../counter/cubit/counter_cubit.dart';
import '../pages.dart';
import '../widgets/navigation_item.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.currentPage.title),
      ),
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
