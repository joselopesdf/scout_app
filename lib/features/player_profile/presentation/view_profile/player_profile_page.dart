import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/shared/widgets/scout_surface.dart';
import '../../../../core/theme/presentation/scout_tokens.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/widgets/logout_button.dart';
import '../player_profile_labels.dart';
import 'player_profile_state.dart';
import 'player_profile_view_model.dart';

class PlayerProfilePage extends ConsumerStatefulWidget {
  const PlayerProfilePage({required this.userId, super.key});

  final String userId;

  @override
  ConsumerState<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends ConsumerState<PlayerProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(playerProfileViewModelProvider.notifier).load(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(playerProfileViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.playerProfileTitle),
        actions: const [LogoutButton()],
      ),
      body: SafeArea(
        child: switch (state) {
          PlayerProfileReady(:final profile) => SingleChildScrollView(
            padding: const EdgeInsets.all(ScoutSpacing.lg),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ScoutSurface(
                      child: Row(
                        children: [
                          _ProfileAvatar(name: profile.fullName),
                          const SizedBox(width: ScoutSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.fullName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                                const SizedBox(height: ScoutSpacing.xs),
                                _PositionBadge(
                                  text: playerPositionText(
                                    l10n,
                                    profile.position,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: ScoutSpacing.md),
                    ScoutSurface(
                      child: Column(
                        children: [
                          _ProfileField(
                            icon: Icons.cake_outlined,
                            label: l10n.playerBirthDate,
                            value: DateFormat.yMd(
                              Localizations.localeOf(context).toLanguageTag(),
                            ).format(profile.birthDate),
                          ),
                          const Divider(),
                          _ProfileField(
                            icon: Icons.directions_run_outlined,
                            label: l10n.playerPreferredFoot,
                            value: preferredFootText(
                              l10n,
                              profile.preferredFoot,
                            ),
                          ),
                          if (profile.currentClub != null) ...[
                            const Divider(),
                            _ProfileField(
                              icon: Icons.shield_outlined,
                              label: l10n.playerCurrentClub,
                              value: profile.currentClub!,
                            ),
                          ],
                          if (profile.bio != null) ...[
                            const Divider(),
                            _ProfileField(
                              icon: Icons.notes_rounded,
                              label: l10n.playerBio,
                              value: profile.bio!,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PlayerProfileNotFound() => _MessageView(
            icon: Icons.person_search_outlined,
            message: l10n.playerProfileNotFound,
            buttonLabel: l10n.tryAgainButton,
            onPressed: () => ref
                .read(playerProfileViewModelProvider.notifier)
                .load(widget.userId, force: true),
          ),
          PlayerProfileFailure() => _MessageView(
            icon: Icons.error_outline_rounded,
            message: l10n.playerProfileLoadError,
            buttonLabel: l10n.tryAgainButton,
            onPressed: () => ref
                .read(playerProfileViewModelProvider.notifier)
                .load(widget.userId, force: true),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(ScoutRadii.medium),
      ),
      child: Text(
        initial,
        style: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(color: colorScheme.secondary),
      ),
    );
  }
}

class _PositionBadge extends StatelessWidget {
  const _PositionBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ScoutSpacing.sm,
        vertical: ScoutSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(ScoutRadii.small),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: ScoutSpacing.xxs),
          child: Icon(
            icon,
            size: 22,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(width: ScoutSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: ScoutSpacing.xxs),
              Text(value, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.icon,
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
  });

  final IconData icon;
  final String message;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ScoutSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 40,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: ScoutSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ScoutSpacing.lg),
            FilledButton(onPressed: onPressed, child: Text(buttonLabel)),
          ],
        ),
      ),
    );
  }
}
