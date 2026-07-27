import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/view_models/logout_state.dart';
import '../../authentication/view_models/logout_view_model.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(logoutViewModelProvider);

    ref.listen(logoutViewModelProvider, (previous, next) {
      if (next case LogoutFailure(:final message)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return IconButton(
      tooltip: 'Terminar sessão',
      onPressed: logoutState is LogoutLoading
          ? null
          : () => ref.read(logoutViewModelProvider.notifier).signOut(),
      icon: const Icon(Icons.logout),
    );
  }
}
