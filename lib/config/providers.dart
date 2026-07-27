import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../data/repositories/account_repository.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/onboarding_repository.dart';
import '../data/repositories/theme_repository.dart';
import '../data/services/firebase_auth_service.dart';
import '../data/services/google_sign_in_service.dart';
import '../data/services/onboarding_service.dart';
import '../data/services/settings_local_service.dart';
import '../data/services/theme_service.dart';
import '../data/services/user_firestore_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn.instance;
});

final settingsBoxProvider = Provider<Box<Object?>>((ref) {
  return Hive.box<Object?>(SettingsLocalService.settingsBoxName);
});

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(ref.watch(firebaseAuthProvider));
});

final googleSignInServiceProvider = Provider<GoogleSignInService>((ref) {
  return GoogleSignInService(ref.watch(googleSignInProvider));
});

final settingsLocalServiceProvider = Provider<SettingsLocalService>((ref) {
  return SettingsLocalService(ref.watch(settingsBoxProvider));
});

final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  return OnboardingService(ref.watch(settingsLocalServiceProvider));
});

final themeServiceProvider = Provider<ThemeService>((ref) {
  return ThemeService(ref.watch(settingsLocalServiceProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    firebaseAuthService: ref.watch(firebaseAuthServiceProvider),
    googleSignInService: ref.watch(googleSignInServiceProvider),
  );
});

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return LocalOnboardingRepository(ref.watch(onboardingServiceProvider));
});

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  return LocalThemeRepository(ref.watch(themeServiceProvider));
});


final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final userFirestoreServiceProvider = Provider<UserFirestoreService>((ref) {
  return UserFirestoreService(
    ref.watch(firebaseFirestoreProvider),
  );
});

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepositoryImpl(
    userFirestoreService: ref.watch(
      userFirestoreServiceProvider,
    ),
  );
});
