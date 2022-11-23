import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/features/authentication/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';

class SignUp {
  final UserRepository userRepository;
  SignUp({required this.userRepository});
  Future<Either<Failure, Either<FirebaseAuthException, User?>>> signUp(String name, String email, String password) {
    return userRepository.signUpUser(name, email, password);
  }
}