import 'package:flutter_checklist/data/services/local_storage_service.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketbaseService {
  PocketbaseService._internal();

  static final PocketbaseService _instance = PocketbaseService._internal();

  factory PocketbaseService() => _instance;

  PocketBase? _pb;

  Future<PocketBase> get instance async {
    if (_pb != null) return _pb!;

    final storage = LocalStorageService();
    final initial = await storage.readString('pb_auth');

    final store = AsyncAuthStore(
      save: (String data) async => storage.saveString('pb_auth', data),
      initial: initial,
    );

    // Use 10.0.2.2 se for Android emulator
    // Use 127.0.0.1 se for Desktop ou Web
    // Se for device físico, use o ip do seu computador
    final baseURL = 'http://192.168.0.185:8090';

    _pb = PocketBase(baseURL, authStore: store);

    return _pb!;
  }
}
