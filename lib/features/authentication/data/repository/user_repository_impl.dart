import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/core/platform/network_info.dart';
import 'package:diary_app_final/features/authentication/data/fire_auth/fire_auth_log_out.dart';
import 'package:diary_app_final/features/authentication/data/fire_auth/fire_auth_sign_in.dart';
import 'package:diary_app_final/features/authentication/data/fire_auth/fire_auth_sign_up.dart';
import 'package:diary_app_final/features/authentication/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {

  final FireAuthSignIn fireAuthSignIn;
  final FireAuthSignUp fireAuthSignUp;
  final FireAuthLogOut fireAuthLogOut;
  final NetworkInfo networkInfo;
  UserRepositoryImpl({required this.fireAuthSignIn, required this.fireAuthLogOut, required this.fireAuthSignUp, required this.networkInfo});

  @override
  Future<Either<Failure, Either<FirebaseAuthException, User?>>> signInUser(String email, String password) async {
    if (await networkInfo.isConnected) {
      final result = await fireAuthSignIn.signIn(email, password);
      return Right(result);
    } else {
      return Left(ServerFailure());
    }
    }

  Future<Either<Failure, Either<FirebaseAuthException, User?>>> signUpUser(String name, String email, String password) async{
    if (await networkInfo.isConnected) {
      final result = await fireAuthSignUp.signUp(name, email, password);
      return Right(result);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  void logOutUser() {
    fireAuthLogOut.logOut();
  }
}