import 'package:flutter/material.dart';
import 'package:flutter_counter/colors.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.text,
    required this.selected,
    required this.icon,
    required this.selectedIcon,
    required this.onPressed,
  });

  final String text;
  final IconData icon;
  final bool selected;
  final IconData selectedIcon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    // final color = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedCrossFade(
        firstChild: _buildUnselectedCust(ColorDef.company100),
        secondChild: _buildSelectedCust(ColorDef.company),
        crossFadeState:
            selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  Widget _buildUnselected(Color color) {
    return Icon(
      icon,
      color: color,
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

  Widget _buildUnselectedCust(Color color) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: const SizedBox(
              height: 3,
              width: 100,
            ),
          ),
          Icon(icon)
        ],
      ),
    );
  }

  Widget _buildSelectedCust(Color color) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
            ),
            child: const SizedBox(
              height: 3,
              width: 100,
            ),
          ),
          Icon(
            icon,
            color: color,
          )
        ],
      ),
    );
  }
}
