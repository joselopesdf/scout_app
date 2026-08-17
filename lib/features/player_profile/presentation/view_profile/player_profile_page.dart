import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      profile.fullName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 24),
                    _ProfileField(
                      label: l10n.playerBirthDate,
                      value: DateFormat.yMd(
                        Localizations.localeOf(context).toLanguageTag(),
                      ).format(profile.birthDate),
                    ),
                    _ProfileField(
                      label: l10n.playerPosition,
                      value: playerPositionText(l10n, profile.position),
                    ),
                    _ProfileField(
                      label: l10n.playerPreferredFoot,
                      value: preferredFootText(l10n, profile.preferredFoot),
                    ),
                    if (profile.currentClub != null)
                      _ProfileField(
                        label: l10n.playerCurrentClub,
                        value: profile.currentClub!,
                      ),
                    if (profile.bio != null)
                      _ProfileField(label: l10n.playerBio, value: profile.bio!),
                  ],
                ),
              ),
            ),
          ),
          PlayerProfileNotFound() => _MessageView(
            message: l10n.playerProfileNotFound,
            buttonLabel: l10n.tryAgainButton,
            onPressed: () => ref
                .read(playerProfileViewModelProvider.notifier)
                .load(widget.userId, force: true),
          ),
          PlayerProfileFailure() => _MessageView(
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

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String message;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onPressed, child: Text(buttonLabel)),
          ],
        ),
      ),
    );
  }
}
