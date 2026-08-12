import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  GoogleSignInService(this._googleSignIn);

  final GoogleSignIn _googleSignIn;
  Future<void>? _initialization;

  Future<String?> signIn() async {
    await _ensureInitialized();

    if (!_googleSignIn.supportsAuthenticate()) {
      throw UnsupportedError(
        'O início de sessão Google não é suportado nesta plataforma.',
      );
    }

    final account = await _googleSignIn.authenticate();
    return account.authentication.idToken;
  }

  Future<void> signOut() async {
    await _ensureInitialized();
    await _googleSignIn.signOut();
  }

  Future<void> _ensureInitialized() {
    return _initialization ??= _googleSignIn.initialize();
  }
}
