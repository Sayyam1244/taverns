import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:taverns/domain/repository/auth_repository.dart';

import '../domain/model/general_model.dart';

class Auth implements AuthRepository {
  @override
  // Future<Either<GeneralError, User>> signWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken,
  //       idToken: gAuth.idToken,
  //     );
  //     await FirebaseAuth.instance.signInWithCredential(credential);

  //     return right(currentUser());
  //   } catch (e) {
  //     return left(GeneralError(
  //         'Error',
  //         e.toString() == Constants.nullError
  //             ? Constants.generalSigninErrorMessage
  //             : e.toString()));
  //   }
  // }

  @override
  Future<Either<GeneralError, User>> signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return right(currentUser());
    } on FirebaseAuthException catch (e) {
      print("Error " + e.toString());
      return left(GeneralError(e.code, e.message ?? ''));
    }
  }

  @override
  Future<Either<GeneralError, User>> signUpWithEmail(String email, String password) async {
    try {
      print(email + ' ' + password);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await currentUser().sendEmailVerification();
      return right(currentUser());
    } on FirebaseAuthException catch (e) {
      return left(GeneralError(e.code, e.message ?? ''));
    }
  }

  @override
  Future<Either<GeneralError, bool>> checkIfUserProfileOnboardingCompleted(User user) async {
    try {
      final isThere = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
      return right(isThere.data()?['profileOnboardingCompleted'] ?? false);
    } on FirebaseException catch (e) {
      return left(GeneralError(e.code, e.message ?? ''));
    }
  }

  @override
  User currentUser() => FirebaseAuth.instance.currentUser!;

  @override
  Future emailverificationStatusStream() async {
    FirebaseAuth.instance.currentUser!.reload();
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future emailtoResetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
