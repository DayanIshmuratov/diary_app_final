abstract class AuthState {}

class LaunchingAuthState extends AuthState {}

class SignedAuthState extends AuthState {}

class NoSignedAuthState extends AuthState {}

class ErrorAuthState extends AuthState {}
