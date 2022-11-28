import 'package:diary_app_final/features/authentication/domain/usecases/sign_in.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/cubit_auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth firebaseAuth;
  AuthCubit({required this.firebaseAuth}) : super(LaunchingAuthState());
  launch() {
    firebaseAuth
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        emit(NoSignedAuthState());
      } else {
        emit(SignedAuthState());
      }
    }
    );
  }
}