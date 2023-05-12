import 'package:flutter/material.dart';

class PopupNavItem extends StatelessWidget {
  const PopupNavItem({
    super.key,
    required this.selected,
    required this.icon,
    required this.onPressed,
  });

  final bool selected;
  final IconData icon;
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
        duration: const Duration(milliseconds: 50),
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
      icon,
      color: color,
      shadows: [Shadow(color: color, blurRadius: 10.0)],
      size: 30,
    );
  }
}
