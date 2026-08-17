import 'package:scout_app/features/authentication/domain/entities/app_user.dart';
import 'package:scout_app/features/authentication/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Future<void> signInWithGoogle() async {}

  @override
  Future<void> signOut() async {}

  @override
  Stream<AppUser?> watchCurrentUser() => const Stream.empty();
}
