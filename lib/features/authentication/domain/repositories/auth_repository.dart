import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> watchCurrentUser();

  Future<void> signInWithGoogle();

  Future<void> signOut();
}
