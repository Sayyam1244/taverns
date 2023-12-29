import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/domain/model/general_model.dart';

abstract class AuthRepository {
  // Future<Either<GeneralError, User>> signWithGoogle();

  Future<Either<GeneralError, User>> signInWithEmail(String email, String password);

  Future<Either<GeneralError, User>> signUpWithEmail(String email, String password);

  Future<Either<GeneralError, bool>> checkIfUserProfileOnboardingCompleted(User user);

  User currentUser();

  Future emailverificationStatusStream();

  // Future<Either<GeneralError, User>>  signWithApple();
}
