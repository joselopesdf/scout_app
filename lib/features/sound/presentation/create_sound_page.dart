import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_sound_state.dart';
import 'create_sound_view_model.dart';

class CreateSoundPage extends ConsumerWidget {
  const CreateSoundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createSoundViewModelProvider);

    final notifier = ref.read(createSoundViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Criar som')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Nome do som',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        onChanged: notifier.setName,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Ex: Risada',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Origem do áudio',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      SegmentedButton<SoundSource>(
                        segments: const [
                          ButtonSegment(
                            value: SoundSource.localFile,
                            icon: Icon(Icons.audio_file),
                            label: Text('Arquivo'),
                          ),
                          ButtonSegment(
                            value: SoundSource.url,
                            icon: Icon(Icons.link),
                            label: Text('URL'),
                          ),
                        ],
                        selected: {state.source},
                        onSelectionChanged: (selection) {
                          notifier.setSource(selection.first);
                        },
                      ),

                      const SizedBox(height: 24),

                      if (state.source == SoundSource.localFile)
                        _LocalFileSection(
                          selectedFilePath: state.selectedFilePath,
                          onChooseFile: () {
                            // Próxima etapa:
                            // abrir file picker real.
                            notifier.setSelectedFile('audio_exemplo.mp3');
                          },
                          onRemoveFile: notifier.clearSelectedFile,
                        )
                      else
                        TextField(
                          keyboardType: TextInputType.url,
                          onChanged: notifier.setUrl,
                          decoration: const InputDecoration(
                            labelText: 'URL do áudio',
                            hintText: 'https://exemplo.com/audio.mp3',
                            prefixIcon: Icon(Icons.link),
                            border: OutlineInputBorder(),
                          ),
                        ),

                      const SizedBox(height: 32),

                      const Text(
                        'Escolha um ícone',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: SoundIcon.values.map((icon) {
                          return _SoundIconButton(
                            icon: icon,
                            selected: state.selectedIcon == icon,
                            onTap: () {
                              notifier.setIcon(icon);
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 40),

                      FilledButton.icon(
                        onPressed: state.canSubmit ? notifier.submit : null,
                        icon: const Icon(Icons.save),
                        label: const Text('Salvar som'),
                      ),
                    ],
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

class _LocalFileSection extends StatelessWidget {
  final String? selectedFilePath;
  final VoidCallback onChooseFile;
  final VoidCallback onRemoveFile;

  const _LocalFileSection({
    required this.selectedFilePath,
    required this.onChooseFile,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedFilePath == null) {
      return OutlinedButton.icon(
        onPressed: onChooseFile,
        icon: const Icon(Icons.folder_open),
        label: const Text('Escolher áudio do dispositivo'),
      );
    }

    return Card(
      child: ListTile(
        leading: const Icon(Icons.audio_file),
        title: Text(
          selectedFilePath!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: onRemoveFile,
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}

class _SoundIconButton extends StatelessWidget {
  final SoundIcon icon;
  final bool selected;
  final VoidCallback onTap;

  const _SoundIconButton({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: selected ? 2 : 1,
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Icon(_iconData(icon), size: 30),
      ),
    );
  }

  IconData _iconData(SoundIcon icon) {
    return switch (icon) {
      SoundIcon.laugh => Icons.sentiment_very_satisfied,
      SoundIcon.football => Icons.sports_soccer,
      SoundIcon.horn => Icons.campaign,
      SoundIcon.clown => Icons.theater_comedy,
      SoundIcon.fire => Icons.local_fire_department,
    };
  }
}
