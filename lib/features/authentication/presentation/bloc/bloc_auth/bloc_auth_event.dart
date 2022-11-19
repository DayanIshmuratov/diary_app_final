abstract class BlocAuthEvent {}

class BlocAuthSignInEvent extends BlocAuthEvent{
  String email;
  String password;
  BlocAuthSignInEvent({required this.email, required this.password});
}

class BlocAuthSignUpEvent extends BlocAuthEvent{
  String name;
  String email;
  String password;
  BlocAuthSignUpEvent({required this.name, required this.email, required this.password});
}

class BlocAuthLogOutEvent extends BlocAuthEvent{}