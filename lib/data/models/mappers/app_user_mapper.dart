

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/models/account_type.dart';
import '../../../domain/models/app_user.dart';
import '../../../domain/models/user_status.dart';


class AppUserMapper {
  const AppUserMapper._();

  static AppUser fromFirestore({
    required String uid,
    required Map<String, dynamic> data,
  }) {
    return AppUser(
      uid: uid,
      email: data['email'] as String?,
      displayName: data['displayName'] as String?,
      photoUrl: data['photoUrl'] as String?,
      accountType: _accountTypeFromString(
        data['accountType'] as String?,
      ),
      onboardingCompleted:
      data['onboardingCompleted'] as bool? ?? false,
      status: _userStatusFromString(
        data['status'] as String?,
      ),
      createdAt: _dateTimeFromFirestore(data['createdAt']),
      updatedAt: _dateTimeFromFirestore(data['updatedAt']),
    );
  }

  static Map<String, dynamic> toCreateMap(AppUser user) {
    return {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'accountType': user.accountType?.name,
      'onboardingCompleted': user.onboardingCompleted,
      'status': user.status.name,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static Map<String, dynamic> toUpdateMap(AppUser user) {
    return {
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'accountType': user.accountType?.name,
      'onboardingCompleted': user.onboardingCompleted,
      'status': user.status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static AccountType? _accountTypeFromString(String? value) {
    return switch (value) {
      null => null,
      'player' => AccountType.player,
      'scout' => AccountType.scout,
      _ => throw FormatException(
        'Tipo de conta inválido no Firestore: $value',
      ),
    };
  }

  static UserStatus _userStatusFromString(String? value) {
    return switch (value) {
      null || 'active' => UserStatus.active,
      'blocked' => UserStatus.blocked,
      'disabled' => UserStatus.disabled,
      _ => throw FormatException(
        'Estado de utilizador inválido no Firestore: $value',
      ),
    };
  }

  static DateTime? _dateTimeFromFirestore(Object? value) {
    if (value == null) {
      return null;
    }

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    throw FormatException(
      'Data inválida recebida do Firestore: $value',
    );
  }
}