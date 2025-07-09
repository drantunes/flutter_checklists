import 'package:flutter_checklist/data/services/pocketbase_service.dart';

class AuthService {
  AuthService._internal();
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  String userId = '';

  Future<bool> createUser(String email, String password) async {
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
    return false;
  }

  Future<bool> login(String email, String password) async {
    final pb = await PocketbaseService().instance;
    final authData = await pb.collection('users').authWithPassword(email, password);

    if (authData.record.id.isNotEmpty && pb.authStore.isValid) {
      userId = authData.record.id;
      return true;
    }
    return false;
  }

  Future<bool> logout() async {
    final pb = await PocketbaseService().instance;
    pb.authStore.clear();
    userId = '';
    return true;
  }

  Future<bool> checkIfUserIsLoggedIn() async {
    final pb = await PocketbaseService().instance;
    return pb.authStore.isValid;
  }
}
