import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/player_position.dart';
import '../../domain/entities/preferred_foot.dart';
import '../player_profile_labels.dart';
import 'create_player_profile_state.dart';
import 'create_player_profile_view_model.dart';

class CreatePlayerProfilePage extends ConsumerStatefulWidget {
  const CreatePlayerProfilePage({
    required this.userId,
    required this.onCompleted,
    this.initialName,
    super.key,
  });

  final String userId;
  final String? initialName;
  final VoidCallback onCompleted;

  @override
  ConsumerState<CreatePlayerProfilePage> createState() =>
      _CreatePlayerProfilePageState();
}

class _CreatePlayerProfilePageState
    extends ConsumerState<CreatePlayerProfilePage> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.invalidate(createPlayerProfileViewModelProvider);
      ref
          .read(createPlayerProfileViewModelProvider.notifier)
          .setInitialName(widget.initialName);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(createPlayerProfileViewModelProvider);
    final viewModel = ref.read(createPlayerProfileViewModelProvider.notifier);

    ref.listen(createPlayerProfileViewModelProvider, (previous, next) {
      if (next.isSuccess && previous?.isSuccess != true) {
        widget.onCompleted();
      }
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_errorText(l10n, next.error!))));
      }
    });

    final locale = Localizations.localeOf(context).toLanguageTag();
    final birthDateText = state.birthDate == null
        ? l10n.playerBirthDateHint
        : DateFormat.yMd(locale).format(state.birthDate!);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(l10n.createPlayerProfileTitle),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _nameController,
                          enabled: !state.isSaving,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: l10n.playerFullName,
                          ),
                          onChanged: viewModel.updateFullName,
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: state.isSaving
                              ? null
                              : () => _selectBirthDate(context, viewModel),
                          icon: const Icon(Icons.calendar_month),
                          label: Text(birthDateText),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<PlayerPosition>(
                          value: state.position,
                          decoration: InputDecoration(
                            labelText: l10n.playerPosition,
                          ),
                          items: PlayerPosition.values
                              .map(
                                (position) => DropdownMenuItem(
                                  value: position,
                                  child: Text(
                                    playerPositionText(l10n, position),
                                  ),
                                ),
                              )
                              .toList(growable: false),
                          onChanged: state.isSaving
                              ? null
                              : viewModel.updatePosition,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<PreferredFoot>(
                          value: state.preferredFoot,
                          decoration: InputDecoration(
                            labelText: l10n.playerPreferredFoot,
                          ),
                          items: PreferredFoot.values
                              .map(
                                (foot) => DropdownMenuItem(
                                  value: foot,
                                  child: Text(preferredFootText(l10n, foot)),
                                ),
                              )
                              .toList(growable: false),
                          onChanged: state.isSaving
                              ? null
                              : viewModel.updatePreferredFoot,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          enabled: !state.isSaving,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: l10n.playerCurrentClubOptional,
                          ),
                          onChanged: viewModel.updateCurrentClub,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          enabled: !state.isSaving,
                          minLines: 3,
                          maxLines: 5,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: l10n.playerBioOptional,
                            alignLabelWithHint: true,
                          ),
                          onChanged: viewModel.updateBio,
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: state.isSaving
                              ? null
                              : () => viewModel.save(widget.userId),
                          child: state.isSaving
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(l10n.saveProfileButton),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(
    BuildContext context,
    CreatePlayerProfileViewModel viewModel,
  ) async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );
    if (selected != null) viewModel.updateBirthDate(selected);
  }
}

String _errorText(AppLocalizations l10n, CreatePlayerProfileError error) {
  return switch (error) {
    CreatePlayerProfileError.fullNameRequired => l10n.playerFullNameRequired,
    CreatePlayerProfileError.birthDateRequired => l10n.playerBirthDateRequired,
    CreatePlayerProfileError.birthDateInFuture => l10n.playerBirthDateFuture,
    CreatePlayerProfileError.positionRequired => l10n.playerPositionRequired,
    CreatePlayerProfileError.preferredFootRequired =>
      l10n.playerPreferredFootRequired,
    CreatePlayerProfileError.saveFailed => l10n.playerProfileSaveError,
  };
}
