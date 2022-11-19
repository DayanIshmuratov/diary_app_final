import 'package:firebase_auth/firebase_auth.dart';

abstract class FireAuthLogOut {
  void logOut();
}

class FireAuthLogOutImpl implements FireAuthLogOut {
  final FirebaseAuth firebaseAuth;
  FireAuthLogOutImpl({required this.firebaseAuth});
  @override
  void logOut() {
    firebaseAuth.signOut();
  }
}