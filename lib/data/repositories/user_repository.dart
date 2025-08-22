import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/services/auth_service.dart';
import 'package:flutter_checklist/utils/result.dart';

enum AuthStatus { loggedIn, loggedOut, idle, online }

final _authState = ValueNotifier(AuthStatus.idle);
ValueNotifier<AuthStatus> get authState => _authState;

class UserRepository {
  AuthService authService;
  // final authError = ValueNotifier("");

  UserRepository(this.authService);

  Future<Result<String>> login(String email, String password) async {
    // authError.value = '';

    final response = await authService.login(email, password);

    if (response case Ok(:final value) when value == true) {
      _authState.value = AuthStatus.loggedIn;

      await Future.delayed(
        Duration(seconds: 1),
        () => _authState.value = AuthStatus.online,
      );
      return Result.ok('');
    }

    if (response case Error(:final error)) {
      // authError.value = error;
      return Result.error(error);
    }
    return Result.error('Erro desconhecido');
  }

  Future<Result<String>> createUserAndLogin(String email, String password) async {
    // authError.value = '';

    final response = await authService.createUser(email, password);

    if (response case Ok(:final value) when value == true) {
      _authState.value = AuthStatus.loggedIn;

      await Future.delayed(
        Duration(seconds: 1),
        () => _authState.value = AuthStatus.online,
      );
      return Result.ok('');
    }

    if (response case Error(:final error)) {
      // authError.value = error;
      return Result.error(error);
    }
    return Result.error('Erro desconhecido');
  }

  Future<void> logout() async {
    final loggedOut = await authService.logout();
    if (loggedOut) {
      _authState.value = AuthStatus.loggedOut;
    }
    return Future.delayed(Duration.zero);
  }

  void checkIfUserIsLoggedIn() async {
    final loggedIn = await authService.checkIfUserIsLoggedIn();
    if (loggedIn) {
      _authState.value = AuthStatus.online;
    } else {
      _authState.value = AuthStatus.loggedOut;
    }
  }
}
