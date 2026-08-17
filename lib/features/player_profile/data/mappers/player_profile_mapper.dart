import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/player_position.dart';
import '../../domain/entities/player_profile.dart';
import '../../domain/entities/preferred_foot.dart';

class PlayerProfileMapper {
  const PlayerProfileMapper._();

  static PlayerProfile fromFirestore({
    required String documentId,
    required Map<String, dynamic> data,
  }) {
    final userId = data['userId'] as String?;
    if (userId == null || userId != documentId) {
      throw const FormatException('Perfil de jogador com userId inválido.');
    }

    return PlayerProfile(
      userId: userId,
      fullName: _requiredString(data, 'fullName'),
      birthDate: _requiredDate(data['birthDate'], 'birthDate'),
      position: _positionFromString(data['position'] as String?),
      preferredFoot: _footFromString(data['preferredFoot'] as String?),
      currentClub: _optionalString(data['currentClub']),
      bio: _optionalString(data['bio']),
      createdAt: _optionalDate(data['createdAt']),
      updatedAt: _optionalDate(data['updatedAt']),
    );
  }

  static Map<String, dynamic> toCreateMap(PlayerProfile profile) {
    return {
      'userId': profile.userId,
      'fullName': profile.fullName.trim(),
      'birthDate': Timestamp.fromDate(profile.birthDate),
      'position': profile.position.name,
      'preferredFoot': profile.preferredFoot.name,
      'currentClub': _nullableTrimmed(profile.currentClub),
      'bio': _nullableTrimmed(profile.bio),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static String _requiredString(Map<String, dynamic> data, String key) {
    final value = data[key] as String?;
    if (value == null || value.trim().isEmpty) {
      throw FormatException('Campo obrigatório inválido: $key.');
    }
    return value.trim();
  }

  static String? _optionalString(Object? value) {
    if (value == null) return null;
    if (value is! String) {
      throw const FormatException('Texto opcional inválido.');
    }
    return _nullableTrimmed(value);
  }

  static String? _nullableTrimmed(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  static DateTime _requiredDate(Object? value, String key) {
    final date = _optionalDate(value);
    if (date == null) throw FormatException('Data obrigatória inválida: $key.');
    return date;
  }

  static DateTime? _optionalDate(Object? value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    throw const FormatException('Data inválida no perfil de jogador.');
  }

  static PlayerPosition _positionFromString(String? value) {
    return switch (value) {
      'goalkeeper' => PlayerPosition.goalkeeper,
      'defender' => PlayerPosition.defender,
      'midfielder' => PlayerPosition.midfielder,
      'forward' => PlayerPosition.forward,
      _ => throw FormatException('Posição inválida: $value.'),
    };
  }

  static PreferredFoot _footFromString(String? value) {
    return switch (value) {
      'left' => PreferredFoot.left,
      'right' => PreferredFoot.right,
      'both' => PreferredFoot.both,
      _ => throw FormatException('Pé preferido inválido: $value.'),
    };
  }
}
