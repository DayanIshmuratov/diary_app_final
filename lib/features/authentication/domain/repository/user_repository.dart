import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<Either<Failure, Either<FirebaseAuthException, User?>>> signInUser(String email, String password);
  // void signUpUser(String name, String email, String password);
  void logOutUser();
}