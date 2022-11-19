abstract class BlocAuthState {}

class BlocAuthInitState extends BlocAuthState {}
class BlocAuthLoadingState extends BlocAuthState {}
class BlocAuthLoadedState extends BlocAuthState {}
class BlocAuthErrorState extends BlocAuthState {
  String message;
  BlocAuthErrorState(this.message);
}