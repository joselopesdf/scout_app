import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../authentication/domain/entities/app_user.dart';
import '../create_profile/create_player_profile_page.dart';
import '../view_profile/player_profile_page.dart';
import 'player_profile_gate_state.dart';
import 'player_profile_gate_view_model.dart';

class PlayerProfileGatePage extends ConsumerStatefulWidget {
  const PlayerProfileGatePage({required this.user, super.key});

  final AppUser user;

  @override
  ConsumerState<PlayerProfileGatePage> createState() =>
      _PlayerProfileGatePageState();
}

class _PlayerProfileGatePageState extends ConsumerState<PlayerProfileGatePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref
          .read(playerProfileGateViewModelProvider.notifier)
          .load(widget.user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(playerProfileGateViewModelProvider);

    return switch (state) {
      PlayerProfileGateNeedsCreation() => CreatePlayerProfilePage(
        userId: widget.user.uid,
        initialName: widget.user.displayName,
        onCompleted: () => ref
            .read(playerProfileGateViewModelProvider.notifier)
            .load(widget.user.uid),
      ),
      PlayerProfileGateReady() => PlayerProfilePage(userId: widget.user.uid),
      PlayerProfileGateFailure() => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.playerProfileLoadError,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => ref
                        .read(playerProfileGateViewModelProvider.notifier)
                        .load(widget.user.uid),
                    child: Text(l10n.tryAgainButton),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      _ => const Scaffold(
        body: SafeArea(child: Center(child: CircularProgressIndicator())),
      ),
    };
  }
}
