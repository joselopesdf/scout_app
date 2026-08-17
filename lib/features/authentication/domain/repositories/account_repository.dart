import '../entities/account_type.dart';
import '../entities/app_user.dart';

abstract interface class AccountRepository {
  Future<AppUser> loadOrCreateUser(AppUser authenticatedUser);

  Future<AppUser> updateAccountType({
    required AppUser user,
    required AccountType accountType,
  });
}
