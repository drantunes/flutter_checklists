import 'package:flutter_checklist/utils/result.dart';

abstract class AuthService {
  String userId = '';

  Future<Result<bool>> createUser(String email, String password);

  Future<Result<bool>> login(String email, String password);

  Future<bool> logout();

  Future<bool> checkIfUserIsLoggedIn();
}
