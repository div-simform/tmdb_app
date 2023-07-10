import 'package:flutter/material.dart';

class NavigationBackWidget extends StatelessWidget {
  const NavigationBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: const Icon(
        Icons.chevron_left,
        size: 30,
      ),
      color: theme.iconTheme.color,
    );
  }
}
