import 'package:diary_app_final/common/error_messages.dart';
import 'package:diary_app_final/features/authentication/domain/usecases/log_out.dart';
import 'package:diary_app_final/features/authentication/domain/usecases/sign_in.dart';
import 'package:diary_app_final/features/authentication/domain/usecases/sign_up.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_event.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocAuthBloc extends Bloc<BlocAuthEvent, BlocAuthState> {
  final SignIn signIn;
  final SignUp signUp;
  final LogOut logOut;
  BlocAuthBloc({required this.signIn, required this.signUp, required this.logOut}) : super(BlocAuthInitState()) {
    on<BlocAuthSignInEvent>((event, emit) async {
        emit(BlocAuthLoadingState());
        final result = await signIn.signIn(event.email, event.password);
        result.fold((failure) => emit(BlocAuthErrorState(ErrorMessages.ServerFailureMessage)),
                (firebaseException) => firebaseException.fold(
                        (l) {
                          print(l.code);
                          emit(BlocAuthErrorState(_signInErrorTranslator(l.code)));
                        },
                        (r) => null));
        emit(BlocAuthInitState());
      }

    );


    on<BlocAuthSignUpEvent>((event, emit) async {
      emit(BlocAuthLoadingState());
      final result = await signUp.signUp(event.name, event.email, event.password);
      result.fold((failure) => emit(BlocAuthErrorState(ErrorMessages.ServerFailureMessage)),
              (firebaseException) => firebaseException.fold(
                  (l) {
                    print(l.code);
                    emit(BlocAuthErrorState(_signUpErrorTranslator(l.code)));
                  },
                  (r) => null));
      emit(BlocAuthInitState());
      }
    );

    on<BlocAuthLogOutEvent>((event, emit)  {
      emit(BlocAuthLoadingState());
      logOut();
      emit(BlocAuthInitState());
    });
  }
}


String _signUpErrorTranslator(String text) {
  switch (text) {
    case "user-not-found" :
      return "Пользователь не найден";
  }
  return text;
}

String _signInErrorTranslator(String text) {
  switch (text) {
    case "user-not-found" :
      return "Пользователь не найден";
  }
  return text;
}