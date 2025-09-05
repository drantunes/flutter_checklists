import 'package:flutter_checklist/data/repositories/user_repository.dart';
import 'package:flutter_checklist/data/services/memory_auth_service.dart';
import 'package:flutter_checklist/data/services/objectbox_service.dart';

Future<(ObjectboxService, UserRepository)> bootstrap() async {
  await Future.delayed(Duration(seconds: 3));

  final objectBox = await ObjectboxService.create();

  // final userRepository = UserRepository(PocketbaseAuthService());
  final userRepository = UserRepository(MemoryAuthService());
  userRepository.checkIfUserIsLoggedIn();

  return (objectBox, userRepository);
}
