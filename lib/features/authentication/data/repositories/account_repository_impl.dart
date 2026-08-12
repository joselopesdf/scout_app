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
}
