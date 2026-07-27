import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/app_user.dart';
import '../services/firebase_auth_service.dart';
import '../services/google_sign_in_service.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> watchCurrentUser();

  Future<void> signInWithGoogle();

  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required FirebaseAuthService firebaseAuthService,
    required GoogleSignInService googleSignInService,
  }) : _firebaseAuthService = firebaseAuthService,
        _googleSignInService = googleSignInService;

  final FirebaseAuthService _firebaseAuthService;
  final GoogleSignInService _googleSignInService;

  @override
  Stream<AppUser?> watchCurrentUser() {
    return _firebaseAuthService
        .authStateChanges()
        .map(_mapUser);
  }

  @override
  Future<void> signInWithGoogle() async {
    final idToken = await _googleSignInService.signIn();

    if (idToken == null || idToken.isEmpty) {
      throw StateError(
        'O Google não devolveu um token de identidade.',
      );
    }

    await _firebaseAuthService.signInWithGoogleIdToken(
      idToken,
    );
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignInService.signOut();
    } finally {
      await _firebaseAuthService.signOut();
    }
  }

  AppUser? _mapUser(User? user) {
    if (user == null) {
      return null;
    }

    return AppUser.fromAuthentication(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}