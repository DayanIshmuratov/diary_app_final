import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/features/authentication/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn {
  final UserRepository userRepository;
  SignIn({required this.userRepository});

  Future<Either<Failure, Either<FirebaseAuthException, User?>>> signIn(String email, String password) {
    return userRepository.signInUser(email, password);
  }
}