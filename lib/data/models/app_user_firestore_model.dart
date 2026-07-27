
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/account_type.dart';
import '../../domain/models/app_user.dart';
import '../../domain/models/user_status.dart';

class AppUserFirestoreModel {
  const AppUserFirestoreModel({
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

  /// Converte um documento do Firestore para o modelo da camada de dados.
  factory AppUserFirestoreModel.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document,
      ) {
    final data = document.data();

    if (!document.exists || data == null) {
      throw StateError(
        'O documento do utilizador ${document.id} não existe.',
      );
    }

    return AppUserFirestoreModel.fromMap(
      uid: document.id,
      map: data,
    );
  }

  /// Converte os dados brutos do Firestore para este modelo.
  factory AppUserFirestoreModel.fromMap({
    required String uid,
    required Map<String, dynamic> map,
  }) {
    return AppUserFirestoreModel(
      uid: uid,
      email: map['email'] as String?,
      displayName: map['displayName'] as String?,
      photoUrl: map['photoUrl'] as String?,
      accountType: _accountTypeFromFirestore(
        map['accountType'] as String?,
      ),
      onboardingCompleted:
      map['onboardingCompleted'] as bool? ?? false,
      status: _userStatusFromFirestore(
        map['status'] as String?,
      ),
      createdAt: _dateTimeFromFirestore(map['createdAt']),
      updatedAt: _dateTimeFromFirestore(map['updatedAt']),
    );
  }

  /// Cria o modelo de dados a partir do modelo de domínio.
  factory AppUserFirestoreModel.fromDomain(AppUser user) {
    return AppUserFirestoreModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      accountType: user.accountType,
      onboardingCompleted: user.onboardingCompleted,
      status: user.status,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  /// Converte o modelo da camada de dados para o domínio.
  AppUser toDomain() {
    return AppUser(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      accountType: accountType,
      onboardingCompleted: onboardingCompleted,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Dados usados para criar users/{uid} pela primeira vez.
  Map<String, dynamic> toCreateMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'accountType': _accountTypeToFirestore(accountType),
      'onboardingCompleted': onboardingCompleted,
      'status': _userStatusToFirestore(status),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  /// Dados comuns que podem ser atualizados posteriormente.
  ///
  /// Não inclui createdAt para não apagar a data de criação original.
  Map<String, dynamic> toUpdateMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'accountType': _accountTypeToFirestore(accountType),
      'onboardingCompleted': onboardingCompleted,
      'status': _userStatusToFirestore(status),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static AccountType? _accountTypeFromFirestore(String? value) {
    if (value == null) {
      return null;
    }

    return switch (value) {
      'player' => AccountType.player,
      'scout' => AccountType.scout,
      _ => throw FormatException(
        'AccountType inválido no Firestore: $value',
      ),
    };
  }

  static String? _accountTypeToFirestore(AccountType? accountType) {
    return switch (accountType) {
      AccountType.player => 'player',
      AccountType.scout => 'scout',
      null => null,
    };
  }

  static UserStatus _userStatusFromFirestore(String? value) {
    return switch (value) {
      'active' => UserStatus.active,
      'blocked' => UserStatus.blocked,
      'disabled' => UserStatus.disabled,
      null => UserStatus.active,
      _ => throw FormatException(
        'UserStatus inválido no Firestore: $value',
      ),
    };
  }

  static String _userStatusToFirestore(UserStatus status) {
    return switch (status) {
      UserStatus.active => 'active',
      UserStatus.blocked => 'blocked',
      UserStatus.disabled => 'disabled',
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