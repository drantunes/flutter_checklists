import 'package:flutter_checklist/data/services/auth_service.dart';
import 'package:flutter_checklist/utils/result.dart';

class MemoryAuthService extends AuthService {
  MemoryAuthService._internal();
  static final MemoryAuthService _instance = MemoryAuthService._internal();
  factory MemoryAuthService() => _instance;

  @override
  String get userId => '';

  @override
  Future<Result<bool>> createUser(String email, String password) async {
    if (password.length >= 8) {
      return login(email, password);
    }
    return Error('Cliente não autorizado');
  }

  @override
  Future<Result<bool>> login(String email, String password) async {
    if (password.length >= 8) {
      userId = "xyz12345";
      return Ok(true);
    }
    return Error('Password precisa ter > 8 caracteres');
  }

  @override
  Future<bool> logout() async {
    userId = '';
    return true;
  }

  @override
  Future<bool> checkIfUserIsLoggedIn() async {
    userId = "xyz12345";
    return true;
  }
}
