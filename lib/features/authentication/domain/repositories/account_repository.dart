import '../entities/app_user.dart';


abstract interface class AccountRepository {
  Future<AppUser> loadOrCreateUser(AppUser authenticatedUser);
}
