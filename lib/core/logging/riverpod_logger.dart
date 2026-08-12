import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class RiverpodLogger extends ProviderObserver {
  const RiverpodLogger();

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    if (!kDebugMode) return;

    developer.log(
      'Provider added: ${context.provider.name ?? context.provider.runtimeType}',
      name: 'Riverpod',
    );
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (!kDebugMode) return;

    developer.log(
      'Provider updated: '
      '${context.provider.name ?? context.provider.runtimeType}',
      name: 'Riverpod',
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    if (!kDebugMode) return;

    developer.log(
      'Provider disposed: '
      '${context.provider.name ?? context.provider.runtimeType}',
      name: 'Riverpod',
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    if (!kDebugMode) return;

    developer.log(
      'Provider failed: '
      '${context.provider.name ?? context.provider.runtimeType}',
      name: 'Riverpod',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
