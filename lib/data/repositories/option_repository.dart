import 'package:flutter_checklist/data/services/local_storage_service.dart';

class OptionRepository {
  final LocalStorageService localStorageService;

  OptionRepository({required this.localStorageService});

  Future<bool> save(bool option) async {
    return localStorageService.saveBool('option', option);
  }

  Future<bool> read() async {
    return localStorageService.readBool('option');
  }
}
