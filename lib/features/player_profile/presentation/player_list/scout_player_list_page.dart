import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/widgets/logout_button.dart';
import '../player_profile_labels.dart';
import 'player_list_state.dart';
import 'player_list_view_model.dart';

class ScoutPlayerListPage extends ConsumerStatefulWidget {
  const ScoutPlayerListPage({super.key});

  @override
  ConsumerState<ScoutPlayerListPage> createState() =>
      _ScoutPlayerListPageState();
}

class _ScoutPlayerListPageState extends ConsumerState<ScoutPlayerListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(playerListViewModelProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(playerListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.playersTitle),
        actions: const [LogoutButton()],
      ),
      body: SafeArea(
        child: switch (state) {
          PlayerListReady(:final players) => RefreshIndicator(
            onRefresh: () =>
                ref.read(playerListViewModelProvider.notifier).load(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: players.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final player = players[index];
                return Card(
                  child: ListTile(
                    title: Text(player.fullName),
                    subtitle: Text(
                      [
                        playerPositionText(l10n, player.position),
                        if (player.currentClub != null) player.currentClub!,
                      ].join(' • '),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(
                      RouteNames.playerProfilePath(player.userId),
                    ),
                  ),
                );
              },
            ),
          ),
          PlayerListEmpty() => _ListMessage(
            message: l10n.playersEmpty,
            buttonLabel: l10n.tryAgainButton,
            onPressed: () =>
                ref.read(playerListViewModelProvider.notifier).load(),
          ),
          PlayerListFailure() => _ListMessage(
            message: l10n.playersLoadError,
            buttonLabel: l10n.tryAgainButton,
            onPressed: () =>
                ref.read(playerListViewModelProvider.notifier).load(),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _ListMessage extends StatelessWidget {
  const _ListMessage({
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
