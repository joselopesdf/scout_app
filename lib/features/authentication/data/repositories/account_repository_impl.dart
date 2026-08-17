import '../../domain/entities/account_type.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/account_repository.dart';
import '../mappers/app_user_mapper.dart';
import '../services/user_firestore_service.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl({required UserFirestoreService userFirestoreService})
    : _userFirestoreService = userFirestoreService;

  final UserFirestoreService _userFirestoreService;

  @override
  Future<AppUser> loadOrCreateUser(AppUser authenticatedUser) async {
    final document = await _userFirestoreService.findByUid(
      authenticatedUser.uid,
    );

    final data = document.data();

    if (document.exists && data != null) {
      return AppUserMapper.fromFirestore(uid: document.id, data: data);
    }

    await _userFirestoreService.create(
      uid: authenticatedUser.uid,
      data: AppUserMapper.toCreateMap(authenticatedUser),
    );

    final createdDocument = await _userFirestoreService.findByUid(
      authenticatedUser.uid,
    );

    final createdData = createdDocument.data();

    if (!createdDocument.exists || createdData == null) {
      throw StateError('O utilizador foi criado, mas não pôde ser carregado.');
    }

    return AppUserMapper.fromFirestore(
      uid: createdDocument.id,
      data: createdData,
    );
  }

  @override
  Future<AppUser> updateAccountType({
    required AppUser user,
    required AccountType accountType,
  }) async {
    final updatedUser = user.copyWith(accountType: accountType);

    await _userFirestoreService.update(
      uid: user.uid,
      data: AppUserMapper.toUpdateMap(updatedUser),
    );

    final updatedDocument = await _userFirestoreService.findByUid(user.uid);

    final updatedData = updatedDocument.data();

    if (!updatedDocument.exists || updatedData == null) {
      throw StateError(
        'O tipo da conta foi atualizado, mas o utilizador não pôde ser carregado.',
      );
    }

    return AppUserMapper.fromFirestore(
      uid: updatedDocument.id,
      data: updatedData,
    );
  }
}
