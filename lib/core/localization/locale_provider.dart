import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_language_enum.dart';

final appLanguageProvider = NotifierProvider<AppLanguageNotifier, AppLanguage>(
  AppLanguageNotifier.new,
);

class AppLanguageNotifier extends Notifier<AppLanguage> {
  @override
  AppLanguage build() {
    return AppLanguage.system;
  }

  void setSystem() {
    state = AppLanguage.system;
  }

  void setPortuguese() {
    state = AppLanguage.portuguese;
  }

  void setEnglish() {
    state = AppLanguage.english;
  }

  void setLanguage(AppLanguage language) {
    state = language;
  }
}

final localeProvider = Provider<Locale?>((ref) {
  final language = ref.watch(appLanguageProvider);

  return switch (language) {
    AppLanguage.system => null,
    AppLanguage.portuguese => const Locale('pt'),
    AppLanguage.english => const Locale('en'),
  };
});
