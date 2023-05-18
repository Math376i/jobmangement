import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.selected,
    required this.icon,
    required this.selectedIcon,
    required this.onPressed,
  });

  final IconData icon;
  final bool selected;
  final IconData selectedIcon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedCrossFade(
        firstChild: _buildUnselected(),
        secondChild: _buildSelected(color),
        crossFadeState:
            selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  Widget _buildUnselected() {
    return Icon(
      icon,
      size: 30,
    );
  }

  Widget _buildSelected(Color color) {
    return Icon(
      selectedIcon,
      color: color,
      size: 30,
    );
  }
}
