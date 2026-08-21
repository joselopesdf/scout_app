import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/scout_brand_mark.dart';
import '../../../../core/shared/widgets/scout_surface.dart';
import '../../../../core/theme/presentation/scout_tokens.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/logout_button.dart';
import '../widgets/theme_toggle_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: const [ThemeToggleButton(), LogoutButton()],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(ScoutSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - (ScoutSpacing.lg * 2),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: ScoutSurface(
                      padding: const EdgeInsets.all(ScoutSpacing.xl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ScoutBrandMark(size: 80),
                          const SizedBox(height: ScoutSpacing.lg),
                          Text(
                            l10n.appName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: ScoutSpacing.sm),
                          Text(
                            l10n.onboardingDescription,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
