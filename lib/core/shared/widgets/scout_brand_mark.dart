import 'package:flutter/material.dart';

import '../../theme/presentation/scout_tokens.dart';

class ScoutBrandMark extends StatelessWidget {
  const ScoutBrandMark({this.size = 72, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(ScoutRadii.medium),
        border: Border.all(
          color: colorScheme.secondary.withValues(alpha: 0.24),
        ),
      ),
      child: Icon(
        Icons.sports_soccer_rounded,
        color: colorScheme.secondary,
        size: size * 0.52,
      ),
    );
  }
}
