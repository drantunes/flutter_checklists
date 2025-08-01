import 'package:flutter_checklist/data/services/auth_service.dart';
import 'package:flutter_checklist/data/services/pocketbase_service.dart';
import 'package:flutter_checklist/utils/result.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketbaseAuthService extends AuthService {
  PocketbaseAuthService._internal();
  static final PocketbaseAuthService _instance = PocketbaseAuthService._internal();
  factory PocketbaseAuthService() => _instance;

  @override
  String get userId => '';

  @override
  Future<Result<bool>> createUser(String email, String password) async {
    try {
      final body = <String, dynamic>{
        "email": email,
        "password": password,
        "passwordConfirm": password,
      };

      final pb = await PocketbaseService().instance;
      final record = await pb.collection('users').create(body: body);

      if (record.collectionId.isNotEmpty) {
        return login(email, password);
      }
    } on ClientException catch (e) {
      return Error(e.response['message']);
    }
    return Result.error('Erro desconhecido ao criar a conta');
  }

  @override
  Future<Result<bool>> login(String email, String password) async {
    try {
      final pb = await PocketbaseService().instance;
      final authData = await pb.collection('users').authWithPassword(email, password);

      if (authData.record.id.isNotEmpty && pb.authStore.isValid) {
        userId = authData.record.id;
        // return Ok(true);
        return Result.ok(true);
      }
    } on ClientException catch (e) {
      return Result.error(e.response['message']);
    }
    return Result.error('ERRO XPTO0001: Erro desconhecido na autenticação');
  }

  @override
  Future<bool> logout() async {
    final pb = await PocketbaseService().instance;
    pb.authStore.clear();
    userId = '';
    return true;
  }

  @override
  Future<bool> checkIfUserIsLoggedIn() async {
    final pb = await PocketbaseService().instance;
    return pb.authStore.isValid;
  }
}
