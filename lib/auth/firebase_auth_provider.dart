import 'package:caravan/auth/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';


import '../global/global.dart';
import 'auth_exception.dart';
import 'auth_provider.dart';
import 'auth_user.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';

import 'package:caravan/auth/auth_provider.dart' as CaravanAuthProvider;

class FirebaseAuthProvider implements CaravanAuthProvider.AuthProvider {
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      
    );
  }

  @override
  Future<AuthUser> createUser(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebaseUser(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      FirebaseAuthProvider firebaseAuthProvider = FirebaseAuthProvider();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        await firebaseAuthProvider.saveLoginData();
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> saveUserData(
      {required String email,
      required String password,
      required String username}) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection("user").doc(user.uid).set({
          "userUID": user.uid,
          "userEmail": user.email,
          "username": username,
        });
        await sharedPreferences!.setString("uid", user.uid);
        await sharedPreferences!.setString("name", username);
        await sharedPreferences!.setString("email", user.email.toString());
      } catch (e) {
        throw GenericAuthException();
      }
    }
  }

  @override
  Future<void> saveLoginData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    FirebaseAuthProvider firebaseAuthProvider = FirebaseAuthProvider();

    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currentUser.uid)
            .get()
            .then((snapshot) async {
          if (snapshot.exists) {
            await sharedPreferences!.setString("uid", currentUser.uid);
            await sharedPreferences!
                .setString("name", snapshot.data()!["username"]);

            await sharedPreferences!
                .setString("email", snapshot.data()!["userEmail"]);
          } else {
            firebaseAuthProvider.logOut();
            throw GenericAuthException();
          }
        });
      } catch (e) {
        throw GenericAuthException();
      }
    }
  }
}
