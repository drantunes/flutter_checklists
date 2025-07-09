import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/repositories/user_repository.dart';

class LoginViewmodel extends ChangeNotifier {
  final UserRepository userRepository;

  LoginViewmodel({required this.userRepository});

  login(String email, String password) {
    userRepository.login(email, password);
  }

  createUserAndLoggedIn(String email, String password) {
    userRepository.createUserAndLogin(email, password);
  }
}
