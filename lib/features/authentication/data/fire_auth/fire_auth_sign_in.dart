import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
abstract class FireAuthSignIn {
  Future<Either<FirebaseAuthException, User?>> signIn(String email, String password);
}
class FireAuthSignInImpl implements FireAuthSignIn {
  final FirebaseAuth firebaseAuth;

  FireAuthSignInImpl({required this.firebaseAuth});

  @override
  Future<Either<FirebaseAuthException, User?>> signIn(String email, String password) async {
    try {
    final credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User? user = credential.user;
    return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(e);
    }
  }
}