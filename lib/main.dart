import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/repositories/user_repository.dart';
import 'package:flutter_checklist/data/services/objectbox_service.dart';
import 'package:flutter_checklist/data/services/pocketbase_auth_service.dart';
import 'package:flutter_checklist/ui/core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await ObjectboxService.create();

  final userRepository = UserRepository(PocketbaseAuthService());
  userRepository.checkIfUserIsLoggedIn();

  runApp(
    App(objectBox: objectBox, userRepository: userRepository),
  );
}
