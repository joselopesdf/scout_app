import 'account_type.dart';
import 'user_status.dart';

class AppUser {
  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.accountType,
    required this.onboardingCompleted,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final AccountType? accountType;
  final bool onboardingCompleted;
  final UserStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AppUser.fromAuthentication({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return AppUser(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      accountType: null,
      onboardingCompleted: false,
      status: UserStatus.active,
      createdAt: null,
      updatedAt: null,
    );
  }

  bool get hasSelectedAccountType {
    return accountType != null;
  }

  bool get isPlayer {
    return accountType == AccountType.player;
  }

  bool get isScout {
    return accountType == AccountType.scout;
  }

  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    AccountType? accountType,
    bool clearAccountType = false,
    bool? onboardingCompleted,
    UserStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      accountType: clearAccountType ? null : accountType ?? this.accountType,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppUser &&
            runtimeType == other.runtimeType &&
            uid == other.uid &&
            email == other.email &&
            displayName == other.displayName &&
            photoUrl == other.photoUrl &&
            accountType == other.accountType &&
            onboardingCompleted == other.onboardingCompleted &&
            status == other.status &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      uid,
      email,
      displayName,
      photoUrl,
      accountType,
      onboardingCompleted,
      status,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'AppUser('
        'uid: $uid, '
        'email: $email, '
        'displayName: $displayName, '
        'accountType: $accountType, '
        'onboardingCompleted: $onboardingCompleted, '
        'status: $status'
        ')';
  }
}
