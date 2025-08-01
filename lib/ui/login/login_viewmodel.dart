import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/repositories/user_repository.dart';
import 'package:flutter_checklist/utils/command.dart';
import 'package:flutter_checklist/utils/result.dart';

typedef UserCredentials = ({String email, String password});

class LoginViewmodel extends ChangeNotifier {
  final UserRepository userRepository;
  late final Command1<String, UserCredentials> login;
  late final Command1<String, UserCredentials> createUserAndLoggin;

  LoginViewmodel({required this.userRepository}) {
    login = Command1(_login);
    createUserAndLoggin = Command1(_createUserAndLoggedIn);
  }

  Future<Result<String>> _login(UserCredentials credentials) {
    return userRepository.login(credentials.email, credentials.password);
  }

  Future<Result<String>> _createUserAndLoggedIn(UserCredentials credentials) {
    return userRepository.createUserAndLogin(credentials.email, credentials.password);
  }
}
