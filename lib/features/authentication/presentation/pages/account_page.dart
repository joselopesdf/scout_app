import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/account_type.dart';
import '../../domain/entities/app_user.dart';
import '../account_type/account_type_state.dart';
import '../providers/update_account_provider.dart';


class AccountTypePage extends ConsumerWidget {
  final AppUser user;
  final VoidCallback onCompleted;

  const AccountTypePage( {
    super.key,
    required this.user,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountTypeViewModelProvider);

    final l10n = AppLocalizations.of(context)!;

    ref.listen<AccountTypeState>(
      accountTypeViewModelProvider,
          (previous, next) {
        debugPrint('LISTEN');
        debugPrint('previous success: ${previous?.isSuccess}');
        debugPrint('next success: ${next.isSuccess}');

        if (next.isSuccess && previous?.isSuccess != true) {
          onCompleted();
        }

        if (next.errorMessage != null &&
            next.errorMessage != previous?.errorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
            ),
          );
        }
      },
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:  Text(l10n.accountTypeTitle),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.accountTypeQuestion,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  l10n.accountTypeSubtitle,
                ),

                const SizedBox(height: 32),

                _AccountTypeCard(
                  title: l10n.player,
                  description:
                      l10n.playerDescription,
                  selected:
                  state.selectedType == AccountType.player,
                  enabled: !state.isSaving,
                  onTap: () {
                    ref
                        .read(accountTypeViewModelProvider.notifier)
                        .selectType(AccountType.player);
                  },
                ),

                const SizedBox(height: 16),

                _AccountTypeCard(
                  title: l10n.scout,
                  description:
                      l10n.scoutDescription,
                  selected:
                  state.selectedType == AccountType.scout,
                  enabled: !state.isSaving,
                  onTap: () {
                    ref
                        .read(accountTypeViewModelProvider.notifier)
                        .selectType(AccountType.scout);
                  },
                ),

                const Spacer(),

                FilledButton(
                  onPressed: state.canContinue
                      ? () {
                    ref
                        .read(
                      accountTypeViewModelProvider.notifier,
                    )
                        .saveAccountType(user);
                  }
                      : null,
                  child: state.isSaving
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : Text(l10n.continueButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const _AccountTypeCard({
    required this.title,
    required this.description,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 4 : 1,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: selected,
                onChanged: enabled ? (_) => onTap() : null,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}