import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/core/platform/network_info.dart';
import 'package:diary_app_final/features/authentication/data/fire_auth/fire_auth_log_out.dart';
import 'package:diary_app_final/features/authentication/data/fire_auth/fire_auth_sign_in.dart';
import 'package:diary_app_final/features/authentication/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {

  final FireAuthSignIn fireAuthSignIn;
  final FireAuthLogOut fireAuthLogOut;
  final NetworkInfo networkInfo;
  UserRepositoryImpl({required this.fireAuthSignIn, required this.fireAuthLogOut, required this.networkInfo});

  @override
  Future<Either<Failure, Either<FirebaseAuthException, User?>>> signInUser(String email, String password) async {
    if (await networkInfo.isConnected) {
      final result = await fireAuthSignIn.signIn(email, password);
      return Right(result);
    } else {
      return Left(ServerFailure());
    }
    // try {
    //
    // } on FirebaseAuthException catch (e) {
    //   return Left(e);
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
    }

  //
  // @override
  // void signUpUser(String name, String email, String password) {}
  //
  @override
  void logOutUser() {
    fireAuthLogOut.logOut();
  }
}