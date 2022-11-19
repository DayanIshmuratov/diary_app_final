import 'package:diary_app_final/features/authentication/domain/repository/user_repository.dart';

class LogOut{
  final UserRepository userRepository;
  LogOut({required this.userRepository});
  void call() {
    userRepository.logOutUser();
  }
}