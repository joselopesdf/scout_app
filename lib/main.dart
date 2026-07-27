import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/bootstrap.dart';
import 'config/riverpod_logger.dart';
import 'ui/authentication/view_models/auth_session_view_model.dart';
import 'ui/core/widgets/scout_app.dart';
import 'ui/onboarding/view_models/onboarding_view_model.dart';

Future<void> main() async {
  await bootstrap();

  final container = ProviderContainer(observers: const [RiverpodLogger()]);

  container.read(onboardingViewModelProvider);
  container.read(authSessionViewModelProvider);

  runApp(
    UncontrolledProviderScope(container: container, child: const ScoutApp()),
  );
}
