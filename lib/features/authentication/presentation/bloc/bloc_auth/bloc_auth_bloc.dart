import 'package:diary_app_final/common/error_messages.dart';
import 'package:diary_app_final/features/authentication/domain/usecases/log_out.dart';
import 'package:diary_app_final/features/authentication/domain/usecases/sign_in.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_event.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocAuthBloc extends Bloc<BlocAuthEvent, BlocAuthState> {
  final SignIn signIn;
  final LogOut logOut;
  BlocAuthBloc({required this.signIn, required this.logOut}) : super(BlocAuthInitState()) {
    on<BlocAuthSignInEvent>((event, emit) async {
        emit(BlocAuthLoadingState());
        final result = await signIn.signIn(event.email, event.password);
        result.fold((failure) => emit(BlocAuthErrorState(ErrorMessages.ServerFailureMessage)),
                (firebaseException) => firebaseException.fold(
                        (l) => emit(BlocAuthErrorState(_signUpErrorSwitcher(l.code))),
                        (r) => null));
      }
    );
    on<BlocAuthLogOutEvent>((event, emit) {
      emit(BlocAuthLoadingState());
      logOut();
    });
  }
}
String _signUpErrorSwitcher(String text) {
  switch (text) {
    case "user-not-found" :
      return "Пользователь не найден";
  }
  return text;
}