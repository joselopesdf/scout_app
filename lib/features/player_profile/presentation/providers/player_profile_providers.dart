import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/firebase_providers.dart';
import '../../data/repositories/player_profile_repository_impl.dart';
import '../../data/services/player_firestore_service.dart';
import '../../domain/repositories/player_profile_repository.dart';

final playerFirestoreServiceProvider = Provider<PlayerFirestoreService>((ref) {
  return PlayerFirestoreService(ref.watch(firebaseFirestoreProvider));
});

final playerProfileRepositoryProvider = Provider<PlayerProfileRepository>((
  ref,
) {
  return PlayerProfileRepositoryImpl(
    service: ref.watch(playerFirestoreServiceProvider),
  );
});
