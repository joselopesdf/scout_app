import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/bootstrap/bootstrap.dart';
import 'core/logging/riverpod_logger.dart';
import 'core/shared/scout_app.dart';
import 'features/authentication/presentation/viewmodels/auth_session_view_model.dart';
import 'features/onboarding/presentation/viewmodels/onboarding_view_model.dart';

Future<void> main() async {
  await bootstrap();

  final container = ProviderContainer(observers: const [RiverpodLogger()]);

  container.read(onboardingViewModelProvider);

  container.read(authSessionViewModelProvider);

  runApp(
    UncontrolledProviderScope(container: container, child: const ScoutApp()),
  );
}
