import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/services/auth_service.dart';

enum AuthStatus { loggedIn, loggedOut, idle, online }

final _authState = ValueNotifier(AuthStatus.idle);
ValueNotifier<AuthStatus> get authState => _authState;

class UserRepository {
  AuthService authService;

  UserRepository(this.authService);

  void login(String email, String password) async {
    final loggedIn = await authService.login(email, password);
    if (loggedIn) {
      _authState.value = AuthStatus.loggedIn;

      await Future.delayed(
        Duration(seconds: 1),
        () => _authState.value = AuthStatus.online,
      );
    }
  }

  void createUserAndLogin(String email, String password) async {
    final loggedIn = await authService.createUser(email, password);
    if (loggedIn) {
      _authState.value = AuthStatus.loggedIn;

      await Future.delayed(
        Duration(seconds: 1),
        () => _authState.value = AuthStatus.online,
      );
    }
  }

  void logout() async {
    final loggedOut = await authService.logout();
    if (loggedOut) {
      _authState.value = AuthStatus.loggedOut;
    }
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
