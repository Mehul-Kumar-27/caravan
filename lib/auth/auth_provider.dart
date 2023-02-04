import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String username,
  });

  Future<void> saveUserData(
    {
    required String email,
    required String password,
    required String username,
  }
  );

  Future<void> saveLoginData();
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({required String toEmail});
}
