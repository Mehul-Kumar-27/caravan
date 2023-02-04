import 'auth_provider.dart';
import 'auth_user.dart';
import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser(
          {required String email,
          required String password,
          required String username}) =>
      provider.createUser(
        email: email,
        password: password,
        username: username,
      );

  @override
  Future<void> saveUserData(
          {required String email,
          required String password,
          required String username}) =>
      provider.saveUserData(
        email: email,
        password: password,
        username: username,
      );

  @override
  Future<void> saveLoginData() => provider.saveLoginData();

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> sendPasswordReset({required String toEmail}) =>
      provider.sendPasswordReset(toEmail: toEmail);
}
